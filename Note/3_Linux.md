# Linux

## Introduction
Simply conclude operation and deployment on linux system

## Environment Setup
### Install System 
- Ubuntu, RedHat, CentOS
- In this project, CentOS8 is installed
### Install SSH
- putty, secureCRT, xShell, finalShell
- In this project, we use finalShell

## Common Statements
`ls [-al] [dir]` - Lists the files and directories in the current working directory.  
`cd` - Changes the current working directory.  
`pwd` - Displays the present working directory.  
`mkdir` - Creates a new directory.  
`rmdir` - Deletes a directory.  
`touch` - Creates a new file.  
`cp` - Copies files or directories.  
`mv` - Moves or renames files or directories.  
`rm` - Deletes files or directories.  
`cat [-n]` - Concatenates and displays the contents of files. (n=showLine)
`more` - show contents by page (enter=oneRow; space=oneScreen; b=lastScreen; q/ctrl+c=exit)
`tail [-f]` - show contents at tail of the file (f=dynamically show changes)
`grep` - Searches for a pattern in a file.  
`chmod` - Changes the permissions of a file or directory.  
`chown` - Changes the owner of a file or directory.  
`sudo` - Executes a command with superuser privileges.  
`top` - Displays real-time system resource usage.  
`df` - Displays disk space usage.  
`du` - Displays disk usage for a directory or file.  
`ping` - Tests network connectivity to a host.  
`ssh` - Connects to a remote server via Secure Shell.  
`scp` - Copies files securely between hosts over a network.  
`tar` - Compresses and archives files.  
`unzip` - Extracts files from a compressed archive.  
`find` - Searches for files and directories matching certain criteria.  
`ps` - Displays information about running processes.  
`kill` - Terminates a process.

- If there are garbled characters, we can configure the encoding:  
`echo 'LANG="en_US.UTF-8"' >> /etc/profile`  
`source /etc/profile`

## Software installation
### Installation methods
#### Binary release 
- download a pre-compiled binary release of the software from the developer's website
- extract the files and run the application
#### rpm
- RPM packages are pre-compiled and include information about dependencies required by the software.
- may encounter issues if you can't resolve the dependencies required by the software
#### yum
- Yum is capable of automatically resolving dependencies
#### source code compile
- download the source code for the software and compiling it on your own system
### Install JDK
- Use tools like winSCP to upload tar tile to the remote
- `tar -zvxf jdk.tar.gz -C /usr/local`
### Install Tomcat
- `tar -zvxf tomcat.tar.gz -C /usr/local`
- go to bin and use `sh startup.sh` to start tomcat service
- Firewall: firewall is running, so we can't access 8080 port
  - turn of firewall: `systemctl disable firewalld`
  - open port: `firewall-cmd --zone=public --add-port=8080/tcp --permanent`
  - take effect: `firewall-cmd --reload`
  - show opened port: `firewall-cmd --zone=public --list-ports`
### Install MySQL 8.0.33
- Download rpm-bundle.tar and extract to 6 rpm files
  - `rpm -ivh mysql-community-common`
  - `rpm -ivh mysql-community-libs`
  - `rpm -ivh mysql-community-devel`
  - `rpm -ivh mysql-community-libs-compat`
  - `rpm -ivh mysql-community-client`
  - `yum install net-tools` if says missing net-tools
  - `rpm -ivh mysql-community-server`
- Run mysql service
  - `systemctl start mysqld` 
  - `systemctl status mysqld`
  - `systemctl enable mysqld` start at boot
- Installing mysql will generate a temporary password
  - `mysql -u root -p` and enter password
  - use following statements to configure
    - `set global validate_password.length=4;` 
    - `set global validate_password.policy=LOW;`
    - `ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';`
  - grant access
    - `CREATE USER 'root'@'%' IDENTIFIED BY 'root@1234';`
    - `GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;`
    - `flush privileges`
## Project Deployment
### Manually Deployment
- package project with maven and upload to server
- run `java -jar project.jar`
#### run at background
- `nohup Command [Arg ...] [&]`: exit terminal won't hang up the program
- `Command` command to execute
- `Arg` set arguments
- `&`: run program at background
-  `nohup java -jar project.jar &> project.log &` run project in background and put log in file
#### kill the program
`ps -ef | grep 'java -jar'`
`kill -9 35685`
### Shell Script
- we developed project and push to remote repository
- then we connect server and pull the newest project and use shell script to compile, package, start it.
- We have to 
  - Install Git
  - Install Maven
  - Write shell
  - grant privilege to run shell
  - execute shell script
- Grant other user access
  - `-r--r--r--`: FileType `-`or`d` Owner `rwx` Group `rwx` OtherUsers `rwx`
  - `r` read `w` write `x` execute
  - we can use `chmod nnn` to grant access. such as `chmod 777 file`