#!/bin/bash
if [ -d ../stage/app/rails ]; then
  echo "preserving previous rails dir"
  mv ../stage/app/rails ../stage/app/rails-`date -Iseconds`
fi
echo "copying rails from dev/app dir to stage/app dir"
scp -r ../dev/app/rails app/
echo "copy completed"
echo "checking if .env exists"
if [ -f ./.env ]; then
  echo ".env file exists, ok!"
else
  echo ".env file doesnt not exist in stage dir, please create and populate a .env file"
  exit 
fi
cd ../stage/app/rails
echo wq! | EDITOR="vi" rails credentials:edit
RAILS_ENV=rails assets:precompile
scp public/assets/* /app/wreck/public/assets
