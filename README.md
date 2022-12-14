# sandbox
Setup scripts of sandbox environment of GovStack

# How to set up GovStack sandbox
On your local computer checkout repo with scripts and change to repo's directory

```
git clone https://github.com/GovStackWorkingGroup/sandbox.git
cd sandbox
```
Create account in DigitalOcean <https://cloud.digitalocean.com/registrations/new>. Be ready to provide credit card details.

Generate API key. On DigitalOcean web site: `Control panel` > `API` > `Generate new token`  
`Control panel` can be reached pressing on DigitalOcean logo.

Enter token name, e.g. `sbx0`. Select both scopes `read` and `write`. Press `Generate token`.
Copy token and store it in file `do_token` NB! DigitalOcean do not show you content of the token after this point.

Open `create_master.sh` file and check that filename of your public SSH key on your local computer is right (variable `PUBLIC_KEY_FILE`).
Create droplet for managing your sandbox

```
./create_master.sh
```

Find and copy IP address of `master` droplet: `Control panel` > `Droplets`  
Copy `do_token` and `master_provision.yml` files to `master` droplet
and login to `master`.
Later you can delete all files created so far on local computer (`rm -rf sandbox`).

<pre>
<code>scp do_token master_provision.yml root@</code><em>{IP-address}</em><code>:</code>
<code>ssh root@</code><em>{IP-address}</em>
</pre>

Continue with work on `master` droplet. Update system software and install `Ansible`. Create empty inventory file

```
apt update
apt -y upgrade
apt -y install python3-pip
pip install ansible
pip install passlib
mkdir /etc/ansible
echo localhost > /etc/ansible/hosts
```

Create non-root accout, set SSH keys, install Terraform, copy token file to user `host` home, set up resolver.conf.s
You will be prompted for password wich will be assigned to 'host' account of `master` droplet and all other created droplets.
The hash of this password will be stored in file `vars_host_hash.yml`

```
ansible-playbook master_provision.yml
```

Use non-root account for further work. Switch to `host` account

```
su - host
```

Create working directory and checkout repo with scripts. Change to repo's directory

```
mkdir wkd
cd wkd
git clone https://github.com/GovStackWorkingGroup/sandbox.git
cd sandbox
```

Create file `structure.yml` with description of your sandbox configuration. Generate Terraform files with infrastructure description

```
ansible-playbook prepare_tf_description.yml
```

Run Terraform to create infrastructure

```
export TF_VAR_do_token=$(cat ~/do_token)
cd tf-files
terraform init
terraform plan
terraform apply
```

Initialize known_hosts

```
./store_known_hosts.sh
```

Create non-root accout, set SSH keys, upgrade system software, set up resolver.conf on all created infrastructure

```
ansible-playbook privision.yml -i hosts
```

Prepare to installation X-Road, clone and update X-Road repo.

```
ansible-playbook prepare_xroad.yml
```

Change to working directory in repo and start intallation. The script will ask password for account 'host' you entered on one of previous steps.

```
cd X-Road/ansible
ansible-playbook xroad_init.yml -i ../../hosts -K
```

_tbc_ 
