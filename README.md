
# WebDAV GoodNotes Backup (tee-webdavserver-goodnotesbackup)

WedDav Server for GoodNotes backup (with monitoring dashboard and restore procedure)




## Usage

GoodNotes should point to `https://teevity-labs.ovh/webdav/username`




## Tech

Overview:
 - Running mostly inside Docker (for me, on a Rocky Linux 10 server) with an nginx companion container for HTTPS
 - Certbot running on the host (with a CRON rule)
 - Data store on the host

Cf: https://chatgpt.com/share/68b4317c-f994-800b-8c60-39db7fb5127e


### Instalation instructions on the host

The directory structure on the host is:
```
/opt/teevity/
├── apache/
│   ├── conf
│   │   └── extra
│   ├── logs
│   └── webdav
│       ├── nicolas
│       └── malo
│       └── htpasswd
├── certs
└── nginx/
    ├── conf.d
    └── logs
```

Execute this to initiate the directory structure
```bash
# Create folder structure
sudo mkdir -p /opt/teevity/{apache/{logs,webdav/{nicolas,malo}},ngidocker exec -it teevity-apache id www-datanx/logs,certs,certbot}
sudo touch /opt/teevity/apache/webdav/DAVLockDB
# We use 33 which is the GUID of the httpd user in the container (found using `docker exec -it teevity-apache id www-data`)
sudo chown -R 33:33 /opt/teevity/apache
sudo chown -R 33:33 /opt/teevity/nginx
sudo chown -R 33:33 /opt/teevity/certs
sudo chown -R 33:33 /opt/teevity/certbot
```

Create some users (by defining their password)
```bash
# Create htpasswd file
sudo touch /opt/teevity/apache/webdav/htpasswd
# Example to add a user
# docker run --rm -it httpd:2.4 htpasswd -Bbn nicolas yourpassword >> /opt/teevity/apache/webdav/htpasswd
# docker run --rm -it httpd:2.4 htpasswd -Bbn malo yourpassword >> /opt/teevity/apache/webdav/htpasswd
```

For the first certificate generation (on the host)
```bash
docker run --rm -it \
  -v /opt/teevity/certs:/etc/letsencrypt \
  -v /var/www/certbot:/var/www/certbot \
  certbot/certbot certonly \
  --webroot --webroot-path=/var/www/certbot \
  -d teevity-labs.ovh
```

To get the initial HTTPS certificate (using the 'webroot' challenge (/.well-known/acme-challenge) served by nginx)
```bash
docker run --rm -it -v /opt/teevity/certs:/etc/letsencrypt -v /opt/teevity/certbot:/var/www/certbot \
  certbot/certbot certonly \
  --webroot \
  --webroot-path=/var/www/certbot \
  -d teevity-labs.ovh
```


### Manually execute some maintenance actions

To renew the HTTPS certificate 
```bash
docker run --rm -v /opt/teevity/certs:/etc/letsencrypt -v /opt/teevity/certbot:/var/www/certbot \
  certbot/certbot renew \
  --quiet \
  --deploy-hook "docker exec teevity-nginx nginx -s reload"
```

To perform the GCS backup
```bash
docker exec -it teevity-apache /usr/local/bin/scripts/backup-to-gcs.sh nicolas gs://mybucket-daily
docker exec -it teevity-apache /usr/local/bin/scripts/backup-to-gcs.sh malo gs://mybucket-weekly
```

Generate a self-signed, temporary certificate
```bash
mkdir -p /opt/teevity/certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /opt/teevity/certs/selfsigned.key \
  -out /opt/teevity/certs/selfsigned.crt \
  -subj "/CN=localhost"
```

### CRON the maintenance actions

To setup the CRON to renew the HTTPS cert
```bash
0 3 * * * docker run --rm \
            -v /opt/teevity/certs:/etc/letsencrypt \
            -v /opt/teevity/certbot:/var/www/certbot  certbot/certbot renew \
            --quiet \
            --deploy-hook "docker exec teevity-nginx nginx -s reload"
```

To setup the CRON to renew the HTTPS cert
```bash
... TODO
```


### Execute the WebDAV server

On the host machine, if the above setup steps have been executed, you can start the WebDAV server with:
```bash
# Use the example environment values as your .env values (you can update this as you need to)
cp dot-env.example .env
# Start the composition
docker compose up -d --build
```

Check if everything is running with:
```bash
docker ps -a
```

Check the logs for a particular service with:
```bash
docker logs teevity-apache
```

Stop the service with:
```bash
docker compose down
```

### Manually perform backups to GCS

To perform the GCS backup
```bash
docker exec -it teevity-apache /usr/local/bin/scripts/backup-to-gcs.sh nicolas gs://mybucket-daily
docker exec -it teevity-apache /usr/local/bin/scripts/backup-to-gcs.sh malo gs://mybucket-weekly
```
