#!/usr/bin/env sh

. "${SCRIPTS_DIR:-scripts}"/common.sh

for output_path in "${OUTPUT_DIR}"/*; do
  s3_path=$(basename "${output_path}")
  if [ -d "${output_path}" ]; then
    aws s3 cp "${output_path}" s3://"${AWS_S3_BUCKET}/${s3_path}" --recursive
  else
    aws s3 cp "${output_path}" s3://"${AWS_S3_BUCKET}/${s3_path}"
  fi
done
