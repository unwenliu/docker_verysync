# docker_versync
versync的docker镜像
## docker-compose启动
```yml
version: "3"

services:
  versync:
    image: unwenliu/verysync:latest
    ports:
      - "8886:8886"
      - "22330:22330/tcp"
      - "22330:22330/udp"
    volumes:
      - "/your_date:/data"
    restart: unless-stopped
```
