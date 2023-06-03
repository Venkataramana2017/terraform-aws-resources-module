#!/bin/bash -xe
yum update -y
service iptables stop
chkconfig iptables off
amazon-linux-extras install -y java-openjdk11 docker 
yum install -y aws-cli git wget unzip jq

###### ssm installation
sudo yum install -y "https://s3.eu-west-2.amazonaws.com/amazon-ssm-eu-west-2/latest/linux_amd64/amazon-ssm-agent.rpm"
sudo systemctl restart amazon-ssm-agent

wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
sudo unzip -o terraform_0.13.5_linux_amd64.zip -d /usr/bin/

#curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
#chmod +x ./kubectl
#mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
#echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
#kubectl version --short --client

### jenkins installation

#sudo tee /etc/yum.repos.d/jenkins.repo<<EOF
#[jenkins]
#name=Jenkins
#baseurl=http://pkg.jenkins.io/redhat
#gpgcheck=0
#EOF

#sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
#sudo yum install -y jenkins
#sudo systemctl start jenkins
#sudo systemctl status jenkins

####  

instanceid=`curl http://169.254.169.254/latest/meta-data/instance-id`
environment=`aws ec2 describe-instances --instance-ids $instanceid --query 'Reservations[*].Instances[*].Tags[?Key==`Environment`][Value]' --output text`

aws eks --region eu-west-2 update-kubeconfig --name "alpian-$environment-eks-cluster"

sudo ansible-galaxy collection install amazon.aws
sudo ansible-galaxy collection install community.kubernetes

openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -outform PEM -pubout -out public.pem
openssl req -new -key private.pem -out certificate.csr -subj "/C=UK/ST=alpian/L=london/O=bed/CN=*.amazonaws.com"
openssl x509 -req -days 365 -in certificate.csr -signkey private.pem -out certificate.crt 
aws iam upload-server-certificate --server-certificate-name jenkins --certificate-body file://certificate.crt  --private-key file://private.pem
