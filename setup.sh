#!/bin/sh
# windows環境、エラー吐かれる場合は git config --global core.autocrlf input を設定した後、再度 git clone を実行
# ref. https://prograshi.com/platform/docker/convert-crlf-to-lf/
PROJECT_NAME='bc_krt'
PROJECT_DIR="/var/www/html"
echo "cd $PROJECT_DIR && composer install"
docker-compose exec web sh -c "cd $PROJECT_DIR && composer install"
docker-compose exec web sh -c "chmod 777 -R $PROJECT_DIR/bootstrap/cache"
docker-compose exec web sh -c "chmod 777 -R $PROJECT_DIR/storage"
docker-compose exec web sh -c "cd $PROJECT_DIR && php artisan migrate"
docker-compose exec web sh -c "cd $PROJECT_DIR && php artisan db:seed"
docker-compose exec web sh -c "chmod 777 -R $PROJECT_DIR/storage"
docker-compose exec web sh -c "cd $PROJECT_DIR && npm install"
docker-compose exec web sh -c "cd $PROJECT_DIR && npm run build"