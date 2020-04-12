#!/bin/bash
docker tag wreck_stage:app_latest 315tky/wreck:app_latest
docker tag wreck_stage:tasks_latest 315tky/wreck:tasks_latest
docker tag wreck_stage:nginx_proxy_latest 315tky/wreck:nginx_proxy_latest
docker tag wreck_stage:postgres_latest 315tky/wreck:postgres_latest
docker tag wreck_stage:mysql_latest 315tky/wreck:mysql_latest

docker login

docker push 315tky/wreck:app_latest
docker push 315tky/wreck:tasks_latest
docker push 315tky/wreck:nginx_proxy_latest
docker push 315tky/wreck:postgres_latest
docker push 315tky/wreck:mysql_latest

echo "do scp as \"nath\" account"
echo "copy the precompiled assets to /app/wreck/public/assets on Prod host"
echo "From Prod host, docker pull the 315/wreck images"
echo "Copy relevant files over, like updated docker-compose, tasks dir etc.."
echo "edit .env if required"
echo "cd wreck/ && docker-compose --compatibility up"

