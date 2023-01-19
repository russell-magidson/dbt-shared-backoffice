#!/bin/bash
version_name=version_scheduler


branch_name=dev_upgrade/${version_name}
directory_destination=$1

if (($# == 1)) ; then
    directory_destination=$1
    branch_name=dev_upgrade/${version_name}
fi
if (($# == 2)) ; then
    directory_destination=$1
    branch_name=$2
fi

echo "======================================"
echo "Directory destination: ${directory_destination}"
echo "Git Branch: ${branch_name}"
echo "======================================"
read -p "-----> Is it ok? (Y/N)" -n 1 -r
echo

if [[ $REPLY == "Y" ]]
then
    echo ""
else
    return
fi

if [ -z "$1" ]
then
    echo "The dbt folder is missing. Please, add the folder after the executor"
else
    
    cp -a ../schedulers/. ../../${directory_destination}/schedulers/
    cp -a ../scripts/. ../../${directory_destination}/scripts/
    cp -a ../cloudbuild.yml ../../${directory_destination}/  
    cp -a ../requirements.txt ../../${directory_destination}/
    cp -a ../workflow-dbt-run.yml ../../${directory_destination}/
    cp -a ../server.py ../../${directory_destination}/
    echo "Copy done in ${directory_destination}"
    function changedir() {
        cd ../../${directory_destination}
        echo "Now in ${directory_destination}"
    }
    changedir

    read -p "Check the folder. Is it ok? (Y/N)" -n 1 -r
    echo
    if [[ $REPLY == "Y" ]]
    then
        echo "I go"
        git branch -M ${branch_name}
        git branch
        git add .
        git commit -m "New version update: ${version_name}"
        git push origin ${branch_name}
    else
        cd ../base-dbt/version_updates/
        echo "Out"
    fi
fi
