# todo before conference

Sätta upp 15 projekt med två floating ips färdigbokade och dit pekar också dns. _ANDERS_
Sätta upp DNS-namn som pekar på en range av floating IPs som vi ser till att binda till workshop-projeketen. _ANDERS_
Ska projektet heta samma sak som den DNS-entry man pekar till adressen i projektet? Ja.
Sätta upp public GitHub-projekt med att filer som behövs. safespring/nextcloud-demo _ANDERS_

Skapa en provisioneringsnod (installera OpenStack API-klienter och ladda ned och installera Terraform-binär). _GABRIEL_

Skapa terraform-skript för att sätta upp Nextcloud-servern. _ANDERS_

Lägg upp följande i en textfil i Git-repot. Dubbelkolla vilken fil man ska lägga in virtual host: _GABRIEL_

```bash
sudo apt update && sudo apt upgrade -y

sudo snap install nextcloud
sudo snap changes nextcloud

sudo nextcloud.manual-install user password

sudo nextcloud.occ config:system:get trusted_domains

sudo nextcloud.occ config:system:set trusted_domains 1 --value=hostname.domain.com
```

Set till att servern går att nå över 80 och 443 och att det finns ett namn som pekar på IP-adressen

```bash
sudo nextcloud.enable-https lets-encrypt

Have you met these requirements? (y/n) y
Please enter an email address (for urgent notices or key recovery): <email>
Please enter your domain name(s) (space-separated): hostname.domain.com
```

Surfa till https://hostname.domain.com och logga in.

På collabora-servern.

```bash
sudo apt install docker.io
certbot -d collabora.domain.com

docker run -t -d -p 127.0.0.1:9980:9980 -e 'domain=hostname\\.domain\\.com' -e 'dictionaries=en se no' --restart always --cap-add MKNOD collabora/code
```

```code
<VirtualHost *:443>
ServerName collabora.domain.com:443

# SSL configuration, you may want to take the easy route instead and use Lets Encrypt!
SSLEngine on
SSLCertificateFile /etc/letsencrypt/live/collabora.domain.com/cert.pem
SSLCertificateChainFile /etc/letsencrypt/live/collabora.domain.com/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/collabora.domain.com/privkey.pem
SSLProtocol             all -SSLv2 -SSLv3
SSLCipherSuite ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS
SSLHonorCipherOrder     on

# Encoded slashes need to be allowed
AllowEncodedSlashes NoDecode

# Container uses a unique non-signed certificate
SSLProxyEngine On
SSLProxyVerify None
SSLProxyCheckPeerCN Off
SSLProxyCheckPeerName Off

# keep the host
ProxyPreserveHost On

# static html, js, images, etc. served from loolwsd
# loleaflet is the client part of LibreOffice Online
ProxyPass           /loleaflet https://127.0.0.1:9980/loleaflet retry=0
ProxyPassReverse    /loleaflet https://127.0.0.1:9980/loleaflet

# WOPI discovery URL
ProxyPass           /hosting/discovery https://127.0.0.1:9980/hosting/discovery retry=0
ProxyPassReverse    /hosting/discovery https://127.0.0.1:9980/hosting/discovery

# Main websocket
ProxyPassMatch "/lool/(.*)/ws$" wss://127.0.0.1:9980/lool/$1/ws nocanon

# Admin Console websocket
ProxyPass   /lool/adminws wss://127.0.0.1:9980/lool/adminws

# Download as, Fullscreen presentation and Image upload operations
ProxyPass           /lool https://127.0.0.1:9980/lool
ProxyPassReverse    /lool https://127.0.0.1:9980/lool

# Endpoint with information about availability of various features
ProxyPass           /hosting/capabilities https://127.0.0.1:9980/hosting/capabilities retry=0
ProxyPassReverse    /hosting/capabilities https://127.0.0.1:9980/hosting/capabilities
</VirtualHost>
```

I Nextcloud - gå till Apps och välj "Disabled" och slå på External Storage.
Gå sedan till inställningar och fyll i bucket, hostname, access key och secret key.
