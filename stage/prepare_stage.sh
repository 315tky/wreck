#!/bin/bash
if [ -d ../stage/app/rails  ]; then
  echo "preserving previous rails dir"
  mv ../stage/app/rails ../stage/app/rails-`date -Iseconds`
  mkdir ../stage/app/rails
fi
echo "copying rails from dev/app dir to stage/app dir"
scp -r ../dev/app/rails/* ./app/rails
echo "copy completed"
echo "checking if .env exists"
if [ -f ./.env ]; then
  echo ".env file exists, ok!"
else
  echo ".env file doesnt not exist in stage dir, please create and populate a .env file"
  exit 
fi
rbenv local 2.7.0
cd ../stage/app/rails
echo wq! | EDITOR="vi" RAILS_ENV=production bin/rails credentials:edit
rm -rf public/*
RAILS_ENV=production bin/rails assets:precompile
scp -r public/* /app/wreck/public/
