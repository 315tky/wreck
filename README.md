**WRECK - Webtool Reporting Eve-online Corporation Killmails**


* Any use of this software should comply with CCP License Agreement detailed here :
https://developers.eveonline.com/resource/license-agreement                       


Instructions for use
============================================================
1. git clone https://github.com/315tky/wreck.git
2. cd wreck
3. cp dev/env dev/.env && cp stage/env stage/.env and edit .env files adding relevant values.
4. To run wreck in dev : 
- 4a. cd dev
- 4b. docker-compose --compatibility up  # Will build images the first time it runs
- 4c. Check http://localhost:8080 in local browser to check if dev rails app site working ok. 
( Note: maybe a short delay when first accessing the site due to webpacker compiling )
5. Wait at least 15mins, and the tasks container should run a cron job that will populate the databases.

Develop code and commit to github as per normal

6. To check app in stage, cd wreck/stage
- 6.1 ./prepare_for_stage.sh
- 6.2 docker-compose --compatibility up
- 6.3 check site in local browser with http://localhost:8181

7. push to prod # TO BE COMPLETED
( need to sort out SSL certs, and relevant config for prod )

More info :
==========
Wreck consists of 5 docker containers 
wreck_app, wreck_tasks, wreck_nginx_proxy, wreck_pg_db, wreck_mysql_db
TBC - need some notes on making EVE ESI tokens etc.. 
