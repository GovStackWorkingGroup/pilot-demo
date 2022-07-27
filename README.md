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
Login to host `master`

<pre>
<code>ssh root@</code><i><code><IP-address></code></i>
</pre>

Update system software and install `Ansible`
```
apt update
apt -y upgrade
apt -y install python3-pip
pip install ansible
```
Return to local computer
```
exit
```
Copy `do_token` and `master_provision.yml` files to host `master`

<pre>
<code>scp do_token master_provision.yml root@</code><i><code><IP-address></code></i><code>:</code>
</pre>

At this point you can delete all files created so far on local computer
```
cd ..
rm -rf sandbox
```
And continue on `master` host

<pre>
<code>ssh root@</code><i><code><IP-address></code></i>
</pre>

