#Установка apache

`sudo yum install httpd`

`sudo service httpd start`

#Install php7.3

`sudo yum install amazon-linux-extras -y`

`sudo amazon-linux-extras | grep php`

`sudo amazon-linux-extras enable php7.3`

`sudo yum clean metadata`

`sudo yum install php php-common php-pear`

`sudo yum install php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip}`

#Install MySQL

`sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm`

`sudo yum install mysql-community-server`

`sudo systemctl enable mysqld`

`sudo systemctl start mysqld`

`sudo grep 'temporary password' /var/log/mysqld.log`

#Временный пароль
kHykXrUlh8-5

`sudo mysql_secure_installation`

#Новый пароль
Qwerty-098

#=========#
Securing the MySQL server deployment.
Enter password for user root:
The existing password for the user account root has expired. Please set a new password.

New password:

Re-enter new password:
The 'validate_password' plugin is installed on the server.
The subsequent steps will run with the existing configuration
of the plugin.
Using existing password for root.

Estimated strength of the password: 100
Change the password for root ? ((Press y|Y for Yes, any other key for No) : n

 ... skipping.
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done!
#=========#

#Install nodeJS (NPM)

`sudo yum install -y gcc-c++ make`

`curl -sL https://rpm.nodesource.com/setup_15.x | sudo -E bash -`

`sudo yum install -y nodejs`



ПКМ по инстансу, Create Image

AMI ID ami-04d9716692b63512d


`terraform init`

#экспортируем ключи для AWS (Documents/terraformAWSAdmin.txt)

`terraform plan`

`terraform apply`


#-------------- Install wordpress--------------#
`mysqladmin -uroot -p create AlexBlog`

`cd /var/www/html`

`sudo wget http://wordpress.org/latest.tar.gz`

`sudo tar -xzvf latest.tar.gz`

`sudo mv wordpress AlexBlog`

#Генерация секрета для конфиг файла /var/www/html/wp-config-sample.php

https://api.wordpress.org/secret-key/1.1/salt/

`sudo cp -r /var/www/html/AlexBlog/* /var/www/html/`

`sudo service httpd restart`

https://aws.amazon.com/ru/getting-started/hands-on/deploy-wordpress-with-amazon-rds/5/


#-----------Site 2---------------#

`sudo npm install -g gatsby-cli`

`sudo yum install git`

#create a new Gatsby site using the hello-world starter

`sudo gatsby new my-hello-world-starter https://github.com/gatsbyjs/gatsby-starter-hello-world`

`cd my-hello-world-starter/`

`sudo gatsby develop -H 0.0.0.0`

#or --host=0.0.0.0
