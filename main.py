import os
import sys
import boto3
from configparser import ConfigParser

namespace = sys.argv[1]
region = sys.argv[2]
bucket_name = sys.argv[3]
bucket_dir = sys.argv[4]
file = sys.argv[5]

config = ConfigParser()
config.read(os.path.expanduser("~/.aws/credentials"))

s3 = boto3.client(
    "s3",
    aws_access_key_id=config.get("default", "aws_access_key_id"),
    aws_secret_access_key=config.get("default", "aws_secret_access_key"),
    region_name=region,
    endpoint_url=f"https://{namespace}.compat.objectstorage.{region}.oraclecloud.com"
)

try:
    s3.upload_file(file, bucket_name, f"{bucket_dir}/{os.path.basename(file)}")
except Exception as e:
    print(e)
    sys.exit(1)
