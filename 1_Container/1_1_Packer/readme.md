1. Установка Vagrant, Packer, Virtualbox.

`sudo apt-get update`

`sudo apt-get install vagrant`

`sudo apt-get install packer`

`sudo apt-get install virtualbox`


Конфигурационный файл для работы Пакера - `ubuntu1804.json`
Файл с инструкциями                       `http/preseed.cfg`
Скрипт для Vagrant                        `scripts/init.sh` и `scripts/cleanup.sh`


Запускаем Пакер
ubuntu-18.08.box
`packer build ubuntu1804.json`

На выходе получаем бокс для Vagrant: `ubuntu-18.08.box`
