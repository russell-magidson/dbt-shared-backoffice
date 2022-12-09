"""
To schedule DBT pipelines via cloud scheduler.
"""
import sys
import os
from base64 import b64encode
import json
from google.auth import default
from googleapiclient import discovery
import yaml
from yaml.loader import SafeLoader
import logging as log

def get_gcp_api_client():
    """ To get API client to interact with GCP API's """
    return discovery.build("cloudscheduler", "v1", cache_discovery=False), discovery.build("run", "v1",
                                                                                           cache_discovery=False)

class CloudScheduler():

    def __init__(self, cloud_run_name, workflow_name, region, service_account, environment, target_project):
        self.csc_client, self.run_client = get_gcp_api_client()
        self.target_project = target_project
        self.location = region
        self.parent = f"projects/{self.target_project}/locations/{self.location}"
        self.could_run_name = f'{cloud_run_name}-{environment}'
        self.workflow_url = f"https://workflowexecutions.googleapis.com/v1/projects/{self.target_project}/locations/{region}/workflows/{workflow_name}/executions"
        self.serviceaccount = service_account
        self.environment = environment

    def _get_cloud_run_url(self):

        log.info("_get_cloud_run_url")
        """" To fetch cloud run service url by its name"""
        parent = f'projects/{self.target_project}/locations/{self.location}'
        request = self.run_client.projects().locations().services()
        request = request.list(parent=parent)
        response = request.execute()
        if response:
            return next(
                (item.get('status').get('url') for item in response.get('items') if self.could_run_name in item.get('status').get('url')),
                None)

    def _get_job_body(self, job_name, schedule_time, time_zone, select,descrption=None):
        """ Prepares cloud scheduler body """

        #selected_resource = f"tag:{resource}" if selection_method == 'tag' else f"path:{resource}"
        arguments = {"cloudRunServiceUrl": f"{self._get_cloud_run_url()}/dbt_run_select", "dbtCommandArgs": select, "env": f"{self.environment}"}
        body = {
            "argument": json.dumps(arguments),
            "callLogLevel": "LOG_ALL_CALLS"
        }
        
        job = {
            "httpTarget": {
                "httpMethod": "POST",
                "uri": self.workflow_url,
                "headers": {"Content-Type": "application/json"},
                "body": b64encode(json.dumps(body).encode('utf-8')).decode('utf-8'),
                "oauthToken": {
                    "serviceAccountEmail": self.serviceaccount,
                    "scope": "https://www.googleapis.com/auth/cloud-platform"
                }
            },
            "schedule": schedule_time,
            "description": descrption,
            "name": job_name,
            "timeZone": time_zone
        }

        return job

    def create_job(self, job_name, cron_schedule, time_zone, descrption,select):
        """ To create a new cloud scheduler job."""
        log.info("+create_job")
        full_job_name = f"projects/{self.target_project}/locations/{self.location}/jobs/csc-wf-dbt-{self.environment}-{job_name}"
        body = self._get_job_body(full_job_name, cron_schedule, time_zone, select,descrption)

        request = self.csc_client.projects().locations().jobs().create(parent=self.parent, body=body)
        try:
            log.info(f"Creating new cloud scheduler job {full_job_name} with body: [{body}]")
            request.execute()
        except Exception as e:
            if "already exists" in str(e):
                log.info(f"Job {full_job_name} already exists. Updating the job details , body: [{body}]")
                self.update_job(full_job_name, body)

    def update_job(self, full_job_name, body):

        log.info("+update_job")
        request = self.csc_client.projects().locations().jobs().patch(name=full_job_name, body=body)
        request.execute()

    def delete_job(self):
        log.info("+delete_job")
        pass


class YamlParser:
    def __init__(self):
        pass

    def parse_yaml_file(self, file):
        from cerberus import Validator
        # schema = eval(open('./schema.py', 'r').read())
        # v = Validator(schema)
        return self._load_doc()
        # is_valid_format = v.validate(doc, schema)

    @staticmethod
    def load_doc(self, file_name):
        with open(file_name, 'r') as stream:
            try:
                return yaml.load(stream)
            except yaml.YAMLError as exception:
                raise exception


def main(environment, service_account, region, target_project, cloud_run_name, workflow_name):
    csc = CloudScheduler(cloud_run_name, workflow_name, region, service_account, environment, target_project)
    for file in os.listdir('./schedulers'):
        # check if current path is a file
        if os.path.isfile(os.path.join('./schedulers', file)) and (file.endswith(".yaml") or file.endswith(".yml")):
            with open(os.path.join('./schedulers', file)) as stream:
                data = yaml.load(stream, Loader=SafeLoader)
                for schedule in data.get('schedules') or []:
                    log.info(f"=======environment information from YAML========{schedule.get('dbt_profile')}")
                    if schedule.get('dbt_profile')  == environment:
                       pipeline_name = schedule.get('name')
                       cron_schedule = schedule.get('cron_schedule')
                       time_zone = schedule.get('time_zone')
                       description = schedule.get('description')
                       select = schedule.get('select')
                       csc.create_job(pipeline_name, cron_schedule, time_zone, description,select)

if __name__ == '__main__':
    environment, service_account, region, target_project, cloud_run_name, workflow_name = sys.argv[1], sys.argv[2], \
                                                                                        sys.argv[3], sys.argv[4], \
                                                                                      sys.argv[5], sys.argv[6]
    log.info(f"Scheduling DBT pipelines for: {environment}--{service_account}--{region}--{target_project}--{cloud_run_name}--{workflow_name}")
    main(environment, service_account, region, target_project, cloud_run_name, workflow_name)
