# docker_verysync
versync的docker镜像

## docker命令启动
```bash
docker run -d --restart=unless-stopped --name verysync -v /your_data:/data -p 8886:8886 unwenliu/verysync:latest
```

## docker-compose启动
```yml
version: "3"

services:
  versync:
    image: unwenliu/verysync:latest
    ports:
      - "8886:8886"
    volumes:
      - "/your_data:/data"
    restart: unless-stopped
```
