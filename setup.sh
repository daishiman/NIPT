#!/bin/sh
# windows環境、エラー吐かれる場合は git config --global core.autocrlf input を設定した後、再度 git clone を実行
# ref. https://prograshi.com/platform/docker/convert-crlf-to-lf/
PROJECT_DIR="/var/www/html"
echo "cd $PROJECT_DIR && composer install"

# 患者様側
docker-compose exec webapp sh -c "cd $PROJECT_DIR && composer install"
docker-compose exec webapp sh -c "chmod 777 -R $PROJECT_DIR/bootstrap/cache"
docker-compose exec webapp sh -c "chmod 777 -R $PROJECT_DIR/storage"
docker-compose exec webapp sh -c "cd $PROJECT_DIR && npm install"
docker-compose exec webapp sh -c "cd $PROJECT_DIR && npm run build"

# 管理画面側
docker-compose exec adminapp sh -c "cd $PROJECT_DIR && composer install"
docker-compose exec adminapp sh -c "chmod 777 -R $PROJECT_DIR/bootstrap/cache"
docker-compose exec adminapp sh -c "chmod 777 -R $PROJECT_DIR/storage"
docker-compose exec adminapp sh -c "cd $PROJECT_DIR && php artisan migrate"
# seederできたら
# docker-compose exec adminapp sh -c "cd $PROJECT_DIR && php artisan db:seed"
docker-compose exec adminapp sh -c "cd $PROJECT_DIR && npm install"
docker-compose exec adminapp sh -c "cd $PROJECT_DIR && npm run build"
