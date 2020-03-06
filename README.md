**WRECK - Webtool Reporting Eve-online Corporation Killmails**

example site : https://pokill.saigos.space


* Any use of this software should comply with CCP License Agreement detailed here :
https://developers.eveonline.com/resource/license-agreement                       


Instructions for use
============================================================

Wreck consists of 4 docker containers`, each in dev and stage :

wreck_app 
wreck_tasks
wreck_nginx_proxy
wreck_pg_db
wreck_mysql_db

Prod you may or may not wish to use nginx_proxy in a container, beware of 
making the rails precompiled assets visible for nginx_proxy in Prod, see note below for more on this.

```git clone https://github.com/315tky/wreck.git```
```cd wreck```
```cp dev/env dev/.env```
```cp stage/env stage/.env```

edit .env files adding relevant values.

<h4>To run wreck in dev</h4> : 

```cd dev```
```docker-compose --compatibility up```
Note, docker-compose command will build images on its first run

Check http://localhost:8080 in local browser to check if dev rails app site working ok.
( Note: maybe a short delay when first accessing the site due to webpacker compiling )

The tasks container by default runs a EVE ESI lookup and data import of killmails every hour.
This will populate the postgres database when it runs.


<h4>To run the app in stage</h4> :

```cd wreck/stage```
```./prepare_for_stage.sh```
```docker-compose --compatibility up```

check site in local browser with http://localhost:8181

Note : Dev and Stage configs differ a little, for example, 
       the rails dir is mounted in the app container in Dev, 
       but copied into the container in Stage.

<h4>To push to prod</h4> :

     Note, rails app public assets are precompiled locally,
     copied over to the Prod VM filesystem, where Nginx can see them.

     Docker images are pushed from stage to Docker Hub, and can then be pulled,
     down from the Prod host from DockerHub. 

     Initially public assets, tasks dir, and docker-compose.yaml etc, need to be copied over to prod host.  

   Configure nginx proxy on prod host correctly to relfect your site URL etc..
   ( Also see this nice reference if wanting to get nginx proxy differently in prod :
     https://medium.com/faun/three-methods-to-share-rails-assets-with-nginx-f39c90bb7d68 )

   From the same dir as the docker-compose.yaml, on the prod host, run
    
   ```docker-compose --compatibility up -d```

  
More info :
==========
TBC - need some notes on making EVE ESI tokens etc.. 
