import logging
import boto3
import botocore
import pandas as pd

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)
s3 = boto3.resource('s3')
s3_client = boto3.client('s3')
S3_BUCKET = 'deploypack'


def handler(event, context):
    LOGGER.info(f'Event structure: {event}')

        # Use boto3 to download the event s3 object key to the /tmp directory.
    BUCKET_NAME = 's3invokbuck'
    keys = ['casual-wear.html', 'excel_db.jpeg', 'image (1).png', 
        'image.png']

    for KEY in keys:
        try:
            local_file_name = '/tmp/'+ KEY
            s3.Bucket(BUCKET_NAME).download_file(KEY, local_file_name)
        except botocore.exceptions.ClientError as e:
            if e.response['Error']['Code'] == "404":
                continue
            else:
                raise
    print('downloaded')

        # Use pandas to read the csv.
    response = s3_client.get_object(Bucket="deploypack", Key="chesterfield_07-12-2022_09-00-00.csv")

    status = response.get("ResponseMetadata", {}).get("HTTPStatusCode")

    if status == 200:
        print(f"Successful S3 get_object response. Status - {status}")
        df = pd.read_csv(response.get("Body"))
        print(df)
    else:
        print(f"Unsuccessful S3 get_object response. Status - {status}")

        # Log the dataframe head.
    logging.info('dataframe head - {}'.format(df.head()))