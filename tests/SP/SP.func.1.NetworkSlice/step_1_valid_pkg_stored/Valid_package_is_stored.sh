#!/bin/bash

delete_sp=$(awk '/delete_sp/ {print $2}' envfile.yml)
echo $delete_sp
Clean=$(curl -X DELETE  ""$delete_sp"")

echo "------Validate_1-----"
upload=$(awk '/upload_package/ {print $2}' envfile.yml)
echo $upload
echo

echo "------Validate_2-----"
Result=$(curl -v -k -i -X POST  -F "package=@$package_name" ""$upload"")
echo $Result
echo

echo "------Validate_3-----"
package_process_uuid=$(printf "$Result" | grep -Po 'package_process_uuid":"\K[^"]+')
echo $package_process_uuid
echo

sleep 20

echo "------Validate_4-----"
status_url=$upload"/status/"$package_process_uuid
echo $status_url
echo

echo "------Validate_5-----"
status=$(curl -k $status_url)
echo $status
echo

echo "------Validate_6-----"
package_id=$(printf "$status" | grep -Po 'package_id":"\K[^"]+')
echo $package_id
echo