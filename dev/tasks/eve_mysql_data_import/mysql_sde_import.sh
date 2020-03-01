############### THIS IS OLD UNUSED, REMOVE AT SOME POINT
#!/bin/bash
#mysql -u username -p dbname <  <sde sql file>
#import to mysql using mysql container
docker exec -i pokill_dev_container_mysql_db_1 sh -c 'exec mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" $MYSQL_DATABASE' < sde-*/sde*
