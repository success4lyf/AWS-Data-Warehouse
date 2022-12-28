#! /bib/bash

docker run -v "$PWD":/var/task "lambci/lambda:build-python3.8" /bin/sh -c "pip install -r requirements.txt -t package/; exit"
cd package
zip -r ../deployment_package.zip .   
cd ..
zip -g deployment_package.zip lambda_function.py