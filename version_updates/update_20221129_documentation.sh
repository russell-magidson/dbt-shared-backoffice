#!/bin/bash
version_name=documentation_v20221129


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
    rm -r ../../${directory_destination}/randstad_documentation/
    cp -a ../randstad_documentation/. ../../${directory_destination}/randstad_documentation/
    cp -a ../README.md ../../${directory_destination}/
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
        cd ..
    else
        cd ../base-dbt/version_updates/
        echo "Out"
    fi
fi
