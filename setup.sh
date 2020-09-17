#!/bin/bash

##### options #####
opptinal_packages=true

install_Bootstrap=true
install_FontAwesome=false
###################

# Rails new
echo "docker-compose run app rails new . -O --force --no-deps --skip-bundle"
docker-compose run app rails new . -O --force --no-deps --skip-bundle

# bundle install
echo "docker-compose build"
docker-compose build


# check_yarn_integrity... error対策
echo "set check_yarn_integrity: false"
sed -icp 's/check_yarn_integrity: true/check_yarn_integrity: false/g' config/webpacker.yml

# webpackがコンパイルするCSSを配置
echo "create CSS for Webpack"
mkdir app/javascript/stylesheets
touch app/javascript/stylesheets/application.scss
mv temp_files/copy_application.html.erb app/views/layouts/application.html.erb
echo 'import "../stylesheets/application.scss";' >> app/javascript/packs/application.js

# optionに応じてパッケージをインストール後再build
if "$opptinal_packages" ; then
echo "install optional packages"
if "$install_Bootstrap" ; then
echo "install Bootstrap"
docker-compose run app yarn add bootstrap jquery popper.js --ignore-optional
echo 'require("bootstrap");' >> app/javascript/packs/application.js
echo '@import "bootstrap/scss/bootstrap";' >> app/javascript/stylesheets/application.scss
mv temp_files/copy_environment.js config/webpack/environment.js
fi

if "$install_FontAwesome" ; then
echo "install Font Awesome"
docker-compose run app yarn add @fortawesome/fontawesome-free
echo 'require("@fortawesome/fontawesome-free");' >> app/javascript/packs/application.js
echo 'import "@fortawesome/fontawesome-free/js/all";' >> app/javascript/packs/application.js
echo '@import "@fortawesome/fontawesome-free/scss/fontawesome";' >> app/javascript/stylesheets/application.scss
fi

docker-compose build
fi

# 不要ファイルの削除
echo "clean temp filse"
rm -r temp_files
rm config/webpacker.ymlcp

# 一旦起動したコンテナを終了
echo "docker-compose down"
docker-compose down