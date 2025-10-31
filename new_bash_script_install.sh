#!/bin/bash

echo "---------------------------------- Update server ----------------------------------"
sudo apt update -y

echo "---------------------------------- Install jdk ----------------------------------"
sudo apt install fontconfig openjdk-21-jre -y

echo "---------------------------------- java version ----------------------------------"
java -version
#openjdk version "21.0.3" 2024-04-16
#OpenJDK Runtime Environment (build 21.0.3+11-Debian-2)
#OpenJDK 64-Bit Server VM (build 21.0.3+11-Debian-2, mixed mode, sharing)

echo "--------------------------------------------------------------------------------------------------------"
echo "------------------------------------ LTS Jenkins Install ------------------------------------ "
echo "--------------------------------------------------------------------------------------------------------"

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "---------------------------------- Update server ----------------------------------"
sudo apt update -y

echo "---------------------------------- Install jenkins ----------------------------------"
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

