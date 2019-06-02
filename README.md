# nextcloud-demo

## how to use the demo environment:

First use terraform to create the instances:

It is a good idea to log into the web console first, to get an understanding of what is going on.

Then do the follwing steps:

Edit the file _openstack.sh_ and fill inn your username, projectname and password. Export the environment variables to your shell with:

```bash
eval `bash openstack.sh`
```

Then enter the terraform directory. We need to edit a few variables. Open the _nextcloud.auto.tfvars_ file, and edit env_name to something more personal, and replace the IP adresses whith the two adresses assigned to you.

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
