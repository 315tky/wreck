**WRECK - Webtool Reporting Eve-online Corporation Killmails**

example site : https://pokill.saigos.space


* Any use of this software should comply with CCP License Agreement detailed here :
https://developers.eveonline.com/resource/license-agreement                       


Instructions for use
============================================================

Wreck consists of 4 docker containers in dev and stage :
wreck_app, wreck_tasks, wreck_nginx_proxy, wreck_pg_db, wreck_mysql_db
Prod you may or may not wish to use nginx_proxy in a container, beware of 
making the rails precompiled assets visible for nginx_proxy in Prod, see note below for more on this.

1. git clone https://github.com/315tky/wreck.git
2. cd wreck
3. cp dev/env dev/.env && cp stage/env stage/.env and edit .env files adding relevant values.
4. To run wreck in dev : 
- cd dev
- docker-compose --compatibility up  # Will build images the first time it runs
- Check http://localhost:8080 in local browser to check if dev rails app site working ok. 
( Note: maybe a short delay when first accessing the site due to webpacker compiling )
5. The tasks container by default runs a EVE ESI lookup and data import of killmails every hours.
   This will populate the postgres database when it runs.

Develop code and commit to github as per normal

6. To run the app in stage, cd wreck/stage
- ./prepare_for_stage.sh
- docker-compose --compatibility up
- check site in local browser with http://localhost:8181

- Note : Dev and Stage configs differ a little, for example, 
  the rails dir is mounted in the app container in Dev, but copied into the container in Stage.

7. push to prod
     Note, rails app public assets are precompiled locally,
     copied over to the Prod VM filesystem, where Nginx can see them.

     Docker images are pushed from stage to Docker Hub, and can then be pulled,
     down from the Prod host from DockerHub. 

   Initially public assets, docker-compose.yaml etc, need to be copied over to prod host.  

   Configure nginx proxy on prod host correctly to relfect your site URL etc..
   ( Also see this nice reference if wanting to get nginx proxy differently in prod :
     https://medium.com/faun/three-methods-to-share-rails-assets-with-nginx-f39c90bb7d68 )

   docker-compose --compatibility up # Will bring up the app.
  
More info :
==========
TBC - need some notes on making EVE ESI tokens etc.. 
