#Устанавливаем Java 8

`sudo apt-get update`

`sudo apt-get install openjdk-8-jre`


#Устанавливаем Jenkins

`wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -`

`sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'`

`sudo apt-get update`

`sudo apt-get install jenkins`

#Дженкинс работает на порту :8080
