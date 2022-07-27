# sandbox
Setup scripts of sandbox environment of GovStack

# How to set up GovStack sandbox
Create working directory on your local computer
```
mkdir mySandbox
cd mySandbox
```
Checkout repo
```
git clone https://github.com/GovStackWorkingGroup/sandbox.git
```
Create account in DigitalOcean
```
https://digitalocean.com
```
Generate API key: Control panel > API > Generate new token
Enter token name, e.g. sbx0. Select both scopes read and write. Press 'Generate token'.
Copy token and store it in file 'do_token'. NB! DigitalOcean do not show you content of the token any more.

Open create_master.sh file and check that filename of your public SSH key is right (variable PUBLIC_KEY_FILE).
Create host for managing your sandbox
```
./create_master.sh
```

