# CLOUD SHELL, GITLAB AND DBT SETUP

Training Basics:
* Code Environment: Google Cloud Shell
* Version Control: GitLab Randstad
* ELT Framework: DBT

Important Note:
This is not a training tutorial for DBT. It is only the basic setup environment to start using DBT inside Randstad.
Previous to set up, please read [DBT STANDARD TRAINING](randstad_documentation/dbt_training.md)

# Cloud Shell Editor Basic Setup

Why Cloud shell? You can use the code tool of your selection for programming, but Cloud Shell has two interesting characteristics:   
1 - You only need to have a Web Browser.  
2 - 100% integrated with Google Cloud from start. Ready to use gsutil, gloud run, google api, etc.  

## Learn more about Google Cloud Shell Editor (Visual Studio Online)

- [Cloud Shell Editor. What is.](https://cloud.google.com/shell)
- [Cloud Shell Video Tutorials](https://www.youtube.com/hashtag/exploringcloudshelleditor)
- [Cloud Shell Documentation](https://cloud.google.com/shell/docs/how-to)

__Open Cloud Shell and make the DBT Workspace__

1 - Open Google Cloud Shell: https://shell.cloud.google.com/  
2 - Press text "Open Home Folder"  
3 - Menu: File -> New Folder (name of the folder: "DBT")  
4 - Select the new folder in the "Explorer" (left side). Press right button and select "Open as Workspace"  
5 - Menu: Terminal -> New Terminal  


# First time with Gitlab?

To complete this stage you need:
- The Randstad gitlab account available (https://eugit.randstadgis.com/)
- your password for update and clone (https://eugit.randstadgis.com/-/profile/password/edit)

If first time with Git, you have to set your randstad email and user name.

In the Cloud Shell Editor - Terminal
```
git config --global user.name "{firstname lastname}"
git config --global user.email "{randstad email}"
```

## How to clone current repository and start developing

Go to your DBT workspace

In the Cloud Shell Editor - Terminal

```
# Inside the "DBT" folder
git clone https://eugit.randstadgis.com/ssc-grp-df-dbt/dbt-{xx}.git
```
Example of folders: dbt-in (India), dbt-es (Spain), dbt-de (Germany), dbt-pt (Portugal), etc

## Cloud Shell Configuration to start using DBT

1. Open the folder DBT as Workspace, and inside this folder
2. Execute following instructions in Menu->Terminal->New Terminal

```
# Inside the "DBT" folder
python3 -m venv .venv
source .venv/Scripts/activate
pip3 install --upgrade pip
pip3 install -r dbt-{xx}/requirements.txt
```

Remember to start programing in the .venv environment to use the correct python libraries of the project
```
# in the DBT folder
source .venv/bin/activate
cd dbt-{xx}
git branch -M dev_{yourname} #Replace {}
export DBT_PROFILES_DIR=.
```


## A basic example of modification

Create a new file "test.txt" and write some text inside

```
git add .
git commit -m "Some summary of the changes you want to update the repository"
git push origin dev_{yourname}
```

## Learn more about Git

- [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file)
- [Upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:


# DBT Basic Setup for Randstad

Only cloning this repository you will not need to setup the dbt project in your code environment.

Inside the dbt workspace:
```
# TO EXECUTE EVERYTIME YOU WANT TO USE DBT
source .venv/bin/activate
cd dbt-{xx}
export DBT_PROFILES_DIR=.

# For executing specific pipeline folders
dbt run --select 01_stg

# For executing specific pipeline tags
dbt run --select tag:zexample

```

# If you want to update your Local Gitlab

```
git pull origin dev_{yourname} --force
```

## Learn more about DBT

- [Learn about DBT](https://docs.getdbt.com/docs/introduction)
- [DBT Training](https://courses.getdbt.com/collections)
- [DBT Reference](https://docs.getdbt.com/reference/dbt_project.yml)
- [DBT Commands](https://docs.getdbt.com/reference/dbt-commands)


# What are the 3 top mistakes of the student when trying this tutorial.

I asuming you have access to Randstad Gitlab and Google Cloud Project

* Forget to execute "source .venv/bin/activate" under the main directory before starting coding.
* Forget to execute "export DBT_PROFILES_DIR=." 
* Not executing "dbt run" under the correct directory (in this case, the folder dbt_{2letterscounty})

[Return to main](../README.md)