import os
import sys
import boto3
import oci

namespace = sys.argv[1]
region = sys.argv[2]
bucket_name = sys.argv[3]
file = sys.argv[4]

config = oci.config.from_file("~/.aws/credentials", profile_name="default")

s3 = boto3.client(
    "s3",
    aws_access_key_id=config["aws_access_key_id"],
    aws_secret_access_key=config["aws_secret_access_key"],
    region_name=region,
    endpoint_url=f"https://{namespace}.compat.objectstorage.{region}.oraclecloud.com"
)

try:
    s3.upload_file(file, bucket_name, f"{os.path.basename(file)}")
except Exception as e:
    print(e)
    sys.exit(1)
