#! /usr/bin/bash
DIGITALOCEAN_TOKEN=$(cat do_token)
PUBLIC_KEY_FILE=~/.ssh/id_rsa.pub
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  -d "{\"name\":\"creator-key\",\"public_key\":\"$(cat $PUBLIC_KEY_FILE)\"}" \
  "https://api.digitalocean.com/v2/account/keys"
KEY_ID=$(curl -s -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  "https://api.digitalocean.com/v2/account/keys" | sed -ne 's/.*"id"://;s/,.*//p')
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  -d '{"name":"master","region":"ams3","size":"s-1vcpu-1gb", "image":"ubuntu-20-04-x64","ssh_keys":'"[$KEY_ID]}" \
  "https://api.digitalocean.com/v2/droplets"
