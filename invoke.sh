#! /bin/bash

export AWS_PROFILE=project

# invoking a Lambda function synchronously
invokelambda1(){
    aws lambda invoke \
    --function-name lambda-stack-LambdaFunction-lwULaGpBadTp \
    --cli-binary-format raw-in-base64-out \
    --payload '{ "key": "value" }' response.json \
    --region eu-west-2
}

# invoking a Lambda function asynchronously
invokelambda2(){
    aws lambda invoke \
    --function-name lambda-stack-LambdaFunction-lwULaGpBadTp  \
    --invocation-type Event \
    --cli-binary-format raw-in-base64-out \
    --payload '{ "key": "value" }' response.json
}

invokelambda1
# invokelambda2