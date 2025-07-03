#!/bin/sh

terraform init  -backend-config="key=$STATE_BUCKET_KEY" -backend-config="bucket=$STATE_BUCKET" -backend-config="region=$AWS_DEFAULT_REGION"

