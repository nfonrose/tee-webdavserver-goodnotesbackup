

The logs showed that GoodNotes interact very swiftly with the WebDAV backup server configured.

```bash
teevity@teeServer-002-SER51Tb32Gb:~/Dev/0.perso/tee-webdavserver-goodnotesbackup/@sandbox/koofrNginxReverseProxy$ docker exec -it teevity-nginx-koofr-reverseproxy /bin/bash
root@d67587ac799a:/# tail -f /var/log/nginx/webdav_access.log
```

```log
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:37:52 +0000] "PROPFIND / HTTP/2.0"                                      207 534  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:37:52 +0000] "PROPFIND /nicolas HTTP/2.0"                               207 544  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:37:53 +0000] "GET /nicolas/.GoodnotesBackupRoot HTTP/2.0"               200 36   "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:37:54 +0000] "PUT /nicolas/.GoodnotesBackupRoot HTTP/2.0"               201 7    "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - - [02/Sep/2025:09:38:41 +0000] "PROPFIND / HTTP/2.0"                                                       401 12   "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:38:42 +0000] "PROPFIND / HTTP/2.0"                                      207 534  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:38:43 +0000] "PROPFIND /nicolas HTTP/2.0"                               207 544  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:38:45 +0000] "GET /nicolas/.GoodnotesBackupRoot HTTP/2.0"               200 36   "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:38:45 +0000] "PUT /nicolas/.GoodnotesBackupRoot HTTP/2.0"               201 7    "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - - [02/Sep/2025:09:54:35 +0000] "PROPFIND /nicolas HTTP/2.0"                                                401 12   "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:54:36 +0000] "PROPFIND /nicolas HTTP/2.0"                               207 544  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:54:37 +0000] "PUT /nicolas/Bloc-note%20Numero%202.pdf HTTP/2.0"         201 7    "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:54:38 +0000] "PROPFIND /nicolas HTTP/2.0"                               207 544  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:54:40 +0000] "PUT /nicolas/Bloc-note%20Numero%202.goodnotes HTTP/2.0"   201 7    "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - - [02/Sep/2025:09:56:05 +0000] "PROPFIND /nicolas HTTP/2.0"                                                401 12   "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:56:05 +0000] "PROPFIND /nicolas HTTP/2.0"                               207 544  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:56:07 +0000] "PUT /nicolas/Bloc-note%20Numero%202.pdf HTTP/2.0"         201 7    "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:56:07 +0000] "PROPFIND /nicolas HTTP/2.0"                               207 544  "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
192.168.1.254 - nfonrose@gmail.com [02/Sep/2025:09:56:08 +0000] "PUT /nicolas/Bloc-note%20Numero%202.goodnotes HTTP/2.0"   201 7    "-" "Goodnotes/3361619.233005576 CFNetwork/3826.500.131 Darwin/24.5.0"
```

REMARK: We also saw an "attack" request
```log
204.76.203.211 - - [02/Sep/2025:09:45:22 +0000] "GET /goform/goform_set_cmd_process?isTest=false&goformId=LOGIN&username=Z3Vlc3Q%%3D&password=MTIzNDU2 HTTP/1.1" 401 12 "-" "Go-http-client/1.1"
```
