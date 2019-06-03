# nextcloud-demo

## how to use the demo environment:

First use terraform to create the instances:

It is a good idea to log into the web console first, to get an understanding of what is going on. You will find the web console at https://portal.cloud.ipnett.no/. Get the username and password at the workshop

Clone the workshop material from git: https://github.com/safespring/nextcloud-demo

Or use one of the pre-made provisioning hosts (get address, username and password at the workshop)

Navigate to the demo folder and edit a few files:

Edit the file _openstack.sh_ and fill inn your username, projectname and password. Export the environment variables to your shell with:

```bash
chmod +x openstack.sh
source ./openstack.sh
```

Then enter the terraform directory. We need to edit a few variables. Open the _nextcloud.auto.tfvars_ file, and edit env_name to something more personal, and replace the IP adresses whith the two adresses assigned to you.

We are using 'cloud-init' to provision the services. See the configuration file _nextcloud.conf_ and update the hostname.

Then run terraform with:

```bash
terraform init
terraform plan
terraform apply
```

(you will see a lot of output from these steps)

Inspect what you have created in the web console

In the terraform step, we created a ssh keypair. We are going to need it for later use. Export it with:

```bash
terraform output ssh_private_key > terraform.key
chmod 700 terraform.key
```

Now you should be able to ssh to your newly created server with:

```bash
$ ssh -i terraform.key -l ubuntu <ip-address of your instance>
```

Now we can ssh to the nextcloud server and install nextcloud:

```bash
sudo apt update && sudo apt upgrade -y

sudo snap install nextcloud
sudo snap changes nextcloud

sudo nextcloud.manual-install user password

sudo nextcloud.occ config:system:get trusted_domains

sudo nextcloud.occ config:system:set trusted_domains 1 --value=<hostname.domain.com>
```

After you have verified that the server is reachable, you can enable letsencrypt certificates:

```bash
sudo nextcloud.enable-https lets-encrypt

Have you met these requirements? (y/n) y
Please enter an email address (for urgent notices or key recovery): <email>
Please enter your domain name(s) (space-separated): hostname.domain.com
```

Now you should have a working nextcloud instance

If we have time - lets try the following:

## Connect to the S3 backend 

In Nextcloud - navigate to Apps and select "Disabled" and turn on external storage

Then go to settings and enter bucket, hostname, access key and secret key.

Server should be https://s3-archive.api.cloud.ipnett.no

