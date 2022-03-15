import os
import boto3
import environ

env = environ.Env()
environ.Env.read_env()

aws_access_key_id = env('aws_access_key_id')
aws_secret_access_key = env('aws_secret_access_key')
region_name = env('region')

def create_session():
    return boto3.session.Session(aws_access_key_id=aws_access_key_id,aws_secret_access_key=aws_secret_access_key,region_name=region_name)

def upload_file(bucket_name,file_path):
    session = create_session()
    s3_res = session.resource('s3')
    file_dir,file_name = os.path.split(file_path)
    bucket = s3_res.Bucket(bucket_name)
    bucket.upload_file(Filename=file_path,Key=file_name)
    s3_url = f"https://{bucket_name}.s3.amazonaws.com/{file_name}"
    return s3_url

# s3_url = upload_file("any-share","test.txt")
# s3_url = upload_file("any-share","waifu.jpg")


# Note that these are not publically accessible right now. Only the AWS account owner can view it. 
# Will make it publically accessible for download later


# https://any-share.s3.amazonaws.com/waifu.jpg
# https://any-share.s3.amazonaws.com/test.txt

