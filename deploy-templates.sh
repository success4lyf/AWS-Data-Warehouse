#! /bin/bash

export AWS_PROFILE=project

function question(){
    echo "Enter 'cs' to create s3 stack"
    echo "Enter 'us' to update s3 stack"
    echo "Enter 'cl' to create lambda stack"
    echo "Enter 'ul' to update lambda stack"
    echo "Enter 'ci' to create lambda-s3-invoke stack"
    echo "Enter 'ui' to update lambda-s3-invoke stack"
    echo "Enter 'dp' to create deploy-lambda-package stack"
    echo "Enter 'udp' to update deploy-lambda-package stack"
    read -p "Enter option : " input
    
    if [ $input == "cs" ]
    then
        s3stackcreate
    elif [ $input == "us" ]
    then
        s3stackupdate
    elif [ $input == "cl" ]
    then
        lambdastackcreate
    elif [ $input == "ul" ]
    then
        lambdastackupdate
    elif [ $input == "ci" ]
    then
        invokestackcreate
    elif [ $input == "ui" ]
    then
        invokestackupdate
    elif [ $input == "dp" ]
    then
        deploypackage
    elif [ $input == "udp" ]
    then
        deploypackageupdate
    else
        echo "No option"
    fi
}

function s3stackcreate(){
    read -r -p "Enter a stack name to create : " stackname
    echo "Creating..."
    aws cloudformation create-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template1-s3-bucket.yaml \
    --region eu-west-2
    echo "Completed!."
}

function s3stackupdate(){
    read -r -p "Enter an existing stack name to update : " stackname
    echo "Updating..."
    aws cloudformation update-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template1-s3-bucket.yaml \
    --region eu-west-2
    echo "Completed!."
}

function lambdastackcreate(){
    read -r -p "Enter a stack name to create : " stackname
    echo "Creating..."
    aws cloudformation create-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template2-lambda.yaml \
    --capabilities CAPABILITY_IAM \
    --region eu-west-2
    echo "Completed!."
}

function lambdastackupdate(){
    read -r -p "Enter a stack name to update : " stackname
    echo "Updating..."
    aws cloudformation update-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template2-lambda.yaml \
    --capabilities CAPABILITY_IAM \
    --region eu-west-2
    echo "Completed!."
}

function invokestackcreate(){
    read -r -p "Enter a stack name to create : " stackname
    echo "Creating..."
    aws cloudformation create-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template3-lambda-s3.yaml \
    --capabilities CAPABILITY_IAM \
    --region eu-west-2
    echo "Completed!."
}

function invokestackupdate(){
    read -r -p "Enter a stack name to update : " stackname
    echo "Updating..."
    aws cloudformation update-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template3-lambda-s3.yaml \
    --capabilities CAPABILITY_IAM \
    --region eu-west-2
    echo "Completed!."
}

function deploypackage(){
    read -r -p "Enter a stack name to create : " stackname
    echo "Creating..."
    aws cloudformation create-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template4-lambda-s3.yaml \
    --region eu-west-2 \
    --parameters \
    ParameterKey=DeploymentBucket,ParameterValue=mainprobuck \
    ParameterKey=DeploymentPackageKey,ParameterValue=my-deployment-package.zip \
    ParameterKey=BucketName,ParameterValue=deploypack \
    --capabilities CAPABILITY_IAM
    echo "Completed!."
}

function deploypackageupdate(){
    read -r -p "Enter a stack name to update : " stackname
    echo "Updating..."
    aws cloudformation update-stack \
    --stack-name $stackname \
    --template-url https://mainprobuck.s3.eu-west-2.amazonaws.com/templates/template4-lambda-s3.yaml \
    --region eu-west-2 \
    --parameters \
    ParameterKey=DeploymentBucket,ParameterValue=mainprobuck \
    ParameterKey=DeploymentPackageKey,ParameterValue=my-deployment-package.zip \
    ParameterKey=BucketName,ParameterValue=deploypack \
    --capabilities CAPABILITY_IAM
    echo "Completed!."
}

question