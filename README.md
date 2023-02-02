# AWS-Data-Warehouse
> An implementation of ETL pipeline in the cloud using AWS Resources such as CloudFormation, S3 Bucket, Lambda, Redshift and others.
## Workflow
![workflow (1)](https://user-images.githubusercontent.com/78314396/214148246-37a8fb21-0a89-4f04-b45c-6527739ca9e1.png)
## Setting up CloudFormation
CloudFormation template to deploy two lambdas which is triggered by an S3 event from two different s3 buckets for each lambda was created  
## ETL Process
Once the cafe puts their csv files into the s3 bucket, the first lambda which contains the extract and transform code will be triggered to perform the extract and transformed process using python, pandas library and boto3. AWS Pandas layer was used as a layer. Onces the extract and transformed code is done, the code uses the boto3 put_object puts the transformed file into the second s3 bucket which is also triggered by the other lambda that contains the load code.

## Modifying ETL lambda to be called by S3 event
## Modify ETL lambda to load data into Redshift

