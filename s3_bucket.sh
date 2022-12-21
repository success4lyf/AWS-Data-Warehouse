#! /bin/bash

export AWS_PROFILE=project

function createbucket(){
    aws s3 mb s3://mainprobuck --region eu-west-2
}

function uploadtemplate(){
    aws s3 cp templates/template1-s3-bucket.yaml s3://mainprobuck/templates/template1-s3-bucket.yaml
}

# createbucket
uploadtemplate
