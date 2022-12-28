#! /bin/bash

export AWS_PROFILE=project

function createmainbucket(){
    aws s3 mb s3://mainprobuck --region eu-west-2
}

function uploads3template(){
    aws s3 cp templates/template1-s3-bucket.yaml s3://mainprobuck/templates/template1-s3-bucket.yaml
}

function uploadlambdatemplate(){
    aws s3 cp templates/template2-lambda.yaml s3://mainprobuck/templates/template2-lambda.yaml
}

function uploadinvoketemplate(){
    aws s3 cp templates/template3-lambda-s3.yaml s3://mainprobuck/templates/template3-lambda-s3.yaml
}

function uploadpackagetemplate(){
    aws s3 cp templates/template4-lambda-s3.yaml s3://mainprobuck/templates/template4-lambda-s3.yaml
}

# createmainbucket
# uploads3template
# uploadlambdatemplate
# uploadinvoketemplate
uploadpackagetemplate