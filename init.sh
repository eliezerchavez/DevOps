#!/bin/bash

sudo rm -fr ./storage

#JFrog Artifactory
mkdir -p ./storage/artifactory/var/etc/
cat <<-EOF > ./storage/artifactory/var/etc/system.yaml
## JFROG ARTIFACTORY SYSTEM CONFIGURATION FILE
## HOW TO USE: comment-out any field and keep the correct yaml indentation by deleting only the leading '#' character.
 
configVersion: 1
 
## NOTE: JFROG_HOME is a place holder for the JFrog root directory containing the deployed product, the home directory for all JFrog products.
## Replace JFROG_HOME with the real path!
## For example, in RPM install, JFROG_HOME=/opt/jfrog
 
## NOTE: Sensitive information such as passwords and join key are encrypted on first read.
## NOTE: The provided commented key and value is the default.
 
## SHARED CONFIGURATIONS
## A shared section for keys across all services in this config
shared:
  ## Logging Configuration (for non-java services)
  ## Artifactory/Access logging can be configured in the separate logback.xml file 
  logging:
    consoleLog:
      ## If true, all service console logs will be redirected to a common console.log
      enabled: true
 
    ## Log rotation settings
    rotation:
      ## The max file size at which enforce rotation
      maxSizeMb: 25
 
      ## The number of backup files to maintain
      maxFiles: 10
 
      ## Whether to compress the backup file
      compress: true
 
  ## Database Configuration
  database:
    type: postgresql
    driver: org.postgresql.Driver
    url: jdbc:postgresql://postgres:5432/artifactory
    username: artifactory
    password: artifactory
EOF

chown -fR 1030:1030 ./storage/artifactory/var
chmod -fR 777 ./storage/artifactory/var

#jenkins
mkdir -p ./storage/jenkins/home

#sonarqube
mkdir -p ./storage/sonarqube/data
mkdir -p ./storage/sonarqube/logs
mkdir -p ./storage/sonarqube/extensions

sudo sysctl -w vm.max_map_count=262144
sudo sysctl -w fs.file-max=65536
sudo bash -c "ulimit -n 65536"
sudo bash -c "ulimit -u 4096"

#postgresql
mkdir -p ./storage/postgres/data
