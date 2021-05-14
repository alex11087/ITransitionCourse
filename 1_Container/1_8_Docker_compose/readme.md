#Install docker-compose
`sudo apt-get install docker-compose`

#Start docker
`docker-compose up -d`

#Remove containers, but preserves db
`docker-compose down`

#Remove all (incl. db)
`docker-compose down --volumes`
