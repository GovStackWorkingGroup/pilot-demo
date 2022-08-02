# sandbox
Setup scripts of sandbox environment of GovStack

# How to set up GovStack sandbox
Checkout repo with scripts and change to repo's directory
```
git clone https://github.com/GovStackWorkingGroup/sandbox.git
cd sandbox
```
Create account in DigitalOcean <https://digitalocean.com>

Generate API key: `Control panel > API > Generate new token`  
Enter token name, e.g. `sbx0`. Select both scopes `read` and `write`. Press `Generate token`.
Copy token and store it in file `do_token` NB! DigitalOcean do not show you content of the token any more.

Open `create_master.sh` file and check that filename of your public SSH key is right (variable `PUBLIC_KEY_FILE`).
Create host for managing your sandbox

```
./create_master.sh
```

Find and copy IP address of `master` droplet: `Control panel > Droplets`  
Copy `do_token` and `master_provision.yml` files to host `master`
and login to host `master`.
Later you can delete all files created so far on local computer (`rm -rf sandbox`).

<pre>
<code>scp do_token master_provision.yml root@</code><em>{IP-address}</em><code>:</code>
<code>ssh root@</code><em>{IP-address}</em>
</pre>

Continue with work on host `master`. Update system software and install `Ansible`

```
apt update
apt -y upgrade
(cd .ssh; ssh-keygen -f id_rsa -N ""; cat id_rsa.pub >>authorized_keys)
apt -y install python3-pip
pip install ansible
```

Create non-root accout, set SSH keys, install Terraform

```
ansible-playbook master_provision.yml -i localhost,
```

Switch to non-root account `host`

```
su - host
```

tbc
