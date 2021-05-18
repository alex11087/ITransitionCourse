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


#Credentials for Github

`ssh-keygen jenkins`

#Ключ jenkins.pub забрасываем в Github (Settings -> SSH and GPG keys -> New SSH key ), jenkins - в Jenkins.

![Image alt](https://github.com/alex11087/ITransitionCourse/blob/main/2_Jenkins/pics/Screenshot%20from%202021-05-18%2012-18-12.png)
![Image alt](https://github.com/alex11087/ITransitionCourse/blob/main/2_Jenkins/pics/Screenshot%20from%202021-05-18%2012-18-22.png)
![Image alt](https://github.com/alex11087/ITransitionCourse/blob/main/2_Jenkins/pics/Screenshot%20from%202021-05-18%2012-18-38.png)
![Image alt](https://github.com/alex11087/ITransitionCourse/blob/main/2_Jenkins/pics/Screenshot%20from%202021-05-18%2012-18-48.png)


#Запускаем job
![Image alt](https://github.com/alex11087/ITransitionCourse/blob/main/2_Jenkins/pics/Screenshot%20from%202021-05-18%2012-10-21.png)
