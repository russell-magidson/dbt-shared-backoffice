# ok
import os
import subprocess
from urllib.parse import quote

import flask
from flask import request


app = flask.Flask(__name__)


def get_response(result, arguments, target, project_dir, request):
    # Format the response
    list_result = (result.stdout).split("\n")
    if 'TOTAL' in list_result[-2]:
        summary_result = {y[0]:int(y[1]) for y in [x.split('=') for x in (list_result[-2].split())[2:]]}
    else:
        summary_result = {'PASS': 0, 'WARN': 0, 'ERROR': 0, 'SKIP': 0, 'TOTAL': 0}
    response = {
        "result": {
            "status": "ok" if result.returncode == 0 else "error",
            "args": result.args,
            "return_code": result.returncode,
            "command_output": list_result,
            "pipelines_executed" : arguments,
            "target" : target,
            "summary_execution" : summary_result
        }
    }
    app.logger.info("Command output: {}".format(response["result"]["command_output"]))
    app.logger.info("Command status: {}".format(response["result"]["status"]))
    print(str(response))
    app.logger.info(
        "Finished processing request on endpoint {}".format(request.base_url)
    )
    return response

@app.route("/", methods=["GET"])
def home():
    app.logger.info("Returning static homepage")
    dbt_name = os.environ.get("DBT_PROJECT_NAME", "BASE")    
    homepage_txt_1 = "<h1>{}: Cloud Run DBT API</h1>".format(dbt_name)
    homepage_txt_2 = """
        <p>Available API routes</p>
        <ul>
        <li>/</li>
        <li>/dbt</li>
        <li>/dbtrunselect/{models}</li>
        </ul>
    """
    homepage_txt = homepage_txt_1 + homepage_txt_2
    return homepage_txt


@app.route("/dbt", methods=["POST"])
def run():
    app.logger.info(
        "Started processing request on endpoint {}".format(request.base_url)
    )
    command = []
    arguments = []
    # Parse the request data
    request_data = request.get_json()
    app.logger.info("Request data: {}".format(request_data))
    if request_data:
        if "cli" in request_data.get("params", {}):
            arguments = request_data["params"]["cli"].strip().split(" ")
            command.extend(arguments)
    # Add an argument for the project dir if not specified
    if not any("--project-dir" in c for c in command):
        project_dir = os.environ.get("DBT_PROJECT_DIR", ".")
        if project_dir:
            command.extend(["--project-dir", project_dir])
    if not any("--target" in c for c in command):
        target = os.environ.get("DBT_TARGET", "dev_target")
        if target:
            command.extend(["--target", target])
    # Execute the dbt command
    result = subprocess.run(
        command, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
    )
    response = get_response(result, arguments, target, project_dir, request)
    return response, 200

@app.route("/dbtrunselect/<path:models>", methods=["GET"])
def dbtrunselect(models):
    app.logger.info(
        "Started processing request on endpoint {}".format(request.base_url)
    )
    command = []
    arguments = []
    if len(models) > 1:
            target = os.environ.get("DBT_TARGET", "dev_target")
            models_ok = models
            command.extend(['dbt','run','--select'])
            arguments = models_ok.strip().split(" ")
            command.extend(arguments)
            project_dir = os.environ.get("DBT_PROJECT_DIR", ".")
            command.extend(["--project-dir", project_dir])
            command.extend(["--target", target])
    # Execute the dbt command
    result = subprocess.run(
        command, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
    )
    response = get_response(result, arguments, target, project_dir, request)
    return response, 200

@app.route("/dbt_run_select", methods=["POST"])
def dbt_run_select():
    app.logger.info(
        "Started processing request on endpoint {}".format(request.base_url)
    )
    command = []
    arguments = []

    request_data = request.get_json()
    arguments = request_data["params"]["cli"].strip().split(" ")
    app.logger.info(
        "Arguments received: {}".format(arguments)
    )
    command.extend(arguments)
    target = os.environ.get("DBT_TARGET", "dev_target")
    project_dir = os.environ.get("DBT_PROJECT_DIR", ".")
    command.extend(["--project-dir", project_dir])
    command.extend(["--target", target])

    # Execute the dbt command    
    result = subprocess.run(
        command, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
    )
    response = get_response(result, arguments, target, project_dir, request)
    app.logger.info(
        "Execution response: {}".format(arguments)
    )
    return response, 200


if __name__ == "__main__":
    app.run()