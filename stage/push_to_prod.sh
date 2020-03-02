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
