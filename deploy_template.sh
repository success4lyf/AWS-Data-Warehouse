#! /bin/bash

export AWS_PROFILE=project

function question(){
    echo "Enter 'cs' to create s3 bucket"
    echo "Enter 'us' to upload template to s3 bucket"
    echo "Enter 'cp' to create a stack"
    echo "Enter 'up' to update a stack"
    read -p "Enter option : " input

    if [ $input == "cs" ]
    then
        createtlbucket
    elif [ $input == "us" ]
    then
        uploadtemplate
    elif [ $input == "cp" ]
    then
        deploypackage
    elif [ $input == "up" ]
    then
        updatepackage
    else
        echo "No option"
    fi
}

function createtlbucket(){
    read -r -p "Enter a bucket name to create : " bucketname
    echo "Creating..."
    aws s3 mb s3://$bucketname --region eu-west-2
}

function uploadtemplate(){
    read -r -p "Enter a bucket name to upload : " bucketname
    read -r -p "Enter the file to upload : " file
    echo "Uploading..."
    aws s3 cp $file s3://$bucketname/$file
}

function deploypackage(){
    read -r -p "Enter a stack name to create : " stackname
    read -r -p "Enter the template url : " template_url
    echo "Creating..."
    aws cloudformation create-stack \
    --stack-name $stackname \
    --template-url $template_url \
    --capabilities CAPABILITY_IAM \
    --region eu-west-2
    echo "Completed!."
}

function updatepackage(){
    read -r -p "Enter a stack name to update : " stackname
    read -r -p "Enter the template url : " template_url
    echo "Updating..."
    aws cloudformation update-stack \
    --stack-name $stackname \
    --template-url $template_url \
    --capabilities CAPABILITY_IAM \
    --region eu-west-2
    echo "Completed!."
}

question