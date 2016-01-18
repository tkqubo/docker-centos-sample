# Docker sample

Sample docker project, following by [SSH でログインできる CentOS の Docker イメージを作ってみる](http://momijiame.tumblr.com/post/125344790446)



## Build and run

```sh
NAME=docker-sample
HTTP_PORT=8080

docker build -t ${NAME} .
docker run -p 2222:22 -p ${HTTP_PORT}:80 -i -t ${NAME}
```

## Access the container

```sh
HTTP_PORT=8080

# 
ip=$(docker-machine ls | grep default | awk '{print $5}' | sed 's,tcp://\(.*\):[0-9]*,\1,g')

curl http://${ip}:${HTTP_PORT}
# or
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l root -p 2222 ${ip}
```

## Shutdown

```sh
id=$(docker ps | grep docker-sample | awk '{print $1}')
docker stop ${id}
docker rm ${id}
```

