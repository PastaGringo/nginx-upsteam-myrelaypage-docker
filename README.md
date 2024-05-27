# nginx-upsteam-myrelaypage-docker
A simple docker container to server [myrelaypage](https://github.com/sandwichfarm/myrelay.page) & [strfry](https://github.com/hoytech/strfry) Nostr relay.  
Should also work with [nostr-rs-relay](https://hub.docker.com/r/scsibug/nostr-rs-relay) but never tried.  

## Docker
Compose file:
```
nano docker-compose.yml
```

```
version: '3.8'
services:

  nginx-upsteam-myrelaypage-docker:
    container_name: nginx-upsteam-myrelaypage-docker
    image: pastagringo/nginx-upsteam-myrelaypage-docker
#    ports:
#      - 80:80
    environment:
      - CONTAINER_MYRELAYPAGE=myrelaypage
      - CONTAINER_NOSTR_RELAY=strfry-nostr-relay

  myrelaypage:
    container_name: myrelaypage
    image: pastagringo/myrelaypage-docker
#    ports:
#      - 80:80

  strfry-nostr-relay:
    container_name: strfry-nostr-relay
    image: pluja/strfry:latest
    volumes:
      - ./strfry/strfry.conf:/etc/strfry.conf
      - ./strfry/strfry-db:/app/strfry-db
#    ports:
#      - 7777:7777
```
Composing file:
```
docker compose up -d && docker compose logs -f
```
```

███╗   ██╗ ██████╗ ██╗███╗   ██╗██╗  ██╗     ██╗   ██╗██████╗ ███████╗████████╗███████╗ █████╗ ███╗   ███╗
████╗  ██║██╔════╝ ██║████╗  ██║╚██╗██╔╝     ██║   ██║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
██╔██╗ ██║██║  ███╗██║██╔██╗ ██║ ╚███╔╝█████╗██║   ██║██████╔╝███████╗   ██║   █████╗  ███████║██╔████╔██║
██║╚██╗██║██║   ██║██║██║╚██╗██║ ██╔██╗╚════╝██║   ██║██╔═══╝ ╚════██║   ██║   ██╔══╝  ██╔══██║██║╚██╔╝██║
██║ ╚████║╚██████╔╝██║██║ ╚████║██╔╝ ██╗     ╚██████╔╝██║     ███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝      ╚═════╝ ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
                                                                                                          
███╗   ███╗██╗   ██╗██████╗ ███████╗██╗      █████╗ ██╗   ██╗██████╗  █████╗  ██████╗ ███████╗
████╗ ████║╚██╗ ██╔╝██╔══██╗██╔════╝██║     ██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝
██╔████╔██║ ╚████╔╝ ██████╔╝█████╗  ██║     ███████║ ╚████╔╝ ██████╔╝███████║██║  ███╗█████╗  
██║╚██╔╝██║  ╚██╔╝  ██╔══██╗██╔══╝  ██║     ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██║██║   ██║██╔══╝  
██║ ╚═╝ ██║   ██║   ██║  ██║███████╗███████╗██║  ██║   ██║   ██║     ██║  ██║╚██████╔╝███████╗
╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
                                                                                              
Getting IP address from myrelaypage ...
>>> Found IP 172.19.0.53 ✅

Getting IP address from strfry-nostr-relay ...
>>> Found IP 172.19.0.23 ✅

Replacing env with envsubst into nginx conf file ... ✅

Starting NGINX ...

2024/04/28 11:40:11 [notice] 1#1: using the "epoll" event method
2024/04/28 11:40:11 [notice] 1#1: nginx/1.26.0
2024/04/28 11:40:11 [notice] 1#1: built by gcc 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
2024/04/28 11:40:11 [notice] 1#1: OS: Linux 5.15.0-101-generic
2024/04/28 11:40:11 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2024/04/28 11:40:11 [notice] 1#1: start worker processes
2024/04/28 11:40:11 [notice] 1#1: start worker process 16
2024/04/28 11:40:11 [notice] 1#1: start worker process 17
2024/04/28 11:40:11 [notice] 1#1: start worker process 18
2024/04/28 11:40:11 [notice] 1#1: start worker process 19
```
You need to expose https domain/subdomain to:
```
nginx-upsteam-myrelaypage-docker:80
```
## MyRelayPage
You can now access to your Nostr relay and find the myrelaypage homepage:

![img](https://slink.fractalized.net/image/0b83dd09-c174-4012-af05-be279c270fc6.png)

You can check if the Nostr relay is working from: https://nostrrr.com/relay/YourNostrRelayURL or https://nostr.watch/relay/YourNostrRelayURL
