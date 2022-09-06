# K8s-flask-deploy

Deploy a flask app with K8s

## Description

Deploys a hello world endpoint using terraform, ansible and microk8s, including a control plan and worker nodes.

## Getting Started

### Dependencies

* Terraform
* Ansible
* Docker
* K8s

Please push the docker image to a Container Registry before deploying
```
Eg: type docker login and hit enter
$ docker login
Username: <username>
Password: <password>
// provide credentials and hit enter

Once your login is succeeded use the below commands to tag your image.

$ docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
SOURCE_IMAGE[:TAG] - you can keep this as your local image
TARGET_IMAGE[:TAG] - <username>/<image-name>:<tag>
Eg:
$ docker tag flask_app:v1.0 vladikes/flask_app:v1.0

Once the docker tag is successful, you can push your image to the container registry using the docker push command.

$ docker push vladikes/flask_app:v1.0
```

### Installing

* Run terraform to init the EC2 instances
```
TF_VAR_AWS_REGION=insert_region TF_VAR_AWS_KEY_PAIR=insert_key_pair terraform -chdir=terraform/ init
TF_VAR_AWS_REGION=insert_region TF_VAR_AWS_KEY_PAIR=insert_key_pair terraform -chdir=terraform/ validate
TF_VAR_AWS_REGION=insert_region TF_VAR_AWS_KEY_PAIR=insert_key_pair terraform -chdir=terraform/ plan
TF_VAR_AWS_REGION=insert_region TF_VAR_AWS_KEY_PAIR=insert_key_pair terraform -chdir=terraform/ apply -input=false -auto-approve
```

* Update hosts vars with the correct EC2 IPs in ansible/inventory.yml and run playbook to init the EC2 instances
```
# Installs collection from ansible galaxy and Deploys K8s master/worker nodes including namespace, kubeconf,docker and kubectl 
ansible-playbook playbook_microk8s.yml
```
