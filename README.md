# sandbox
Setup scripts of sandbox environment of GovStack

# How to set up GovStack sandbox
Checkout repo with scripts and change to repo's directory
```
git clone https://github.com/GovStackWorkingGroup/sandbox.git
cd sandbox
```
Create account in DigitalOcean <https://cloud.digitalocean.com/registrations/new>. Be ready to provide credit card details.

Generate API key. On DigitalOcean web site: `Control panel` > `API` > `Generate new token`  
`Control panel` can be reached pressing on logo.

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

Continue with work on `master` droplet. Update system software and install `Ansible`

```
apt update
apt -y upgrade
apt -y install python3-pip
pip install ansible
```

Create non-root accout, set SSH keys, install Terraform

```
ansible-playbook master_provision.yml -i localhost,
```

Use non-root account for further work. Switch to `host` account

```
su - host
```

_tbc_ 
