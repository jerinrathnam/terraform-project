#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
aws s3 cp s3://${s3_bucket_name}/website/index.html /home/ec2-user/index.html
aws s3 cp s3://${s3_bucket_name}/website/Polish_20220517_223858461.png /home/ec2-user/Polish_20220517_223858461.png
sudo rm /usr/share/nginx/html/index.html
cp /home/ec2-user/index.html /usr/share/nginx/html/index.html
cp /home/ec2-user/Polish_20220517_223858461.png  /usr/share/nginx/html/Polish_20220517_223858461.png