#!/bin/bash

conf="conf/eve_mysql_sde_download.conf"

if [ -f $conf ];then
  . $conf
else
  echo "conf file not found, exiting"
  exit
fi

if [ ! -d $archived_sde ];then
  echo "no sde archive dir found, creating"
  mkdir $archived_sde
fi

if [ -d $sde_dir ];then
  echo "old sde directory found, moving to archive" 
  date=`date -Iseconds`
  mv $sde_dir $archived_sde/$date
fi

if [ -f $md5_file ];then
  echo "old md5sum directory found, removing" 
  rm $md5_file
fi

# get latest md5_file
echo "downloading latest md5sum for check"
curl $curl_flags ./$md5_file $md5_url

if [ ! -f $mysql_file ];then 
  echo "no mysql tar file found, downloading new"
  curl $curl_flags ./$mysql_file $mysql_url
  latest_md5_checksum=`cat $md5_file`
  mysql_file_checksum=`/usr/bin/md5sum $mysql_file`
  if [ "$latest_md5_checksum" = "$mysql_file_checksum" ];then  
     echo "checksums of newly downloaded tar file matches latest md5sum" 
     tar xvfj $mysql_file 
  else
     echo "something wrong, latest md5sum and mysql_tar file from $mysql_url remote server do not match"
     exit
  fi
else
  latest_md5_checksum=`cat $md5_file`
  mysql_file_checksum=`/usr/bin/md5sum $mysql_file`
  if [ "$latest_md5_checksum" = "$mysql_file_checksum" ];then
    echo "latest md5sum file matches previous mysql tar file, nothing to do"
    exit
  else
    curl $curl_flags ./$mysql_file $mysql_url
    mysql_file_checksum=`/usr/bin/md5sum $mysql_file`
    if [ "$latest_md5_checksum" = "$mysql_file_checksum" ];then
      tar xvfj $mysql_file
    else 
      echo "something wrong, latest md5sum and mysql_tar file from $mysql_url remote server do no match"
      exit
    fi
  fi
fi
#   
mysql_container=`docker ps --format '{{.Names}}' --filter "name=wreck_mysql" --filter "status=running"`
if [ $mysql_container ];then
  echo "running import, latest eve mysql sde -> local wreck_mysql db container"
  docker exec -i mysql sh -c 'exec mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" $MYSQL_DATABASE' < $sde_dir/$sde_file
  echo "sde import completed"
else
  echo "wreck_mysql container is not running, cannot import, exiting"
  exit
fi
