
# jira

Welcome to your puppet-jira module.The structure was enerated with the use of the PDK, tool, more documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with jira](#setup)
    * [What jira affects](#what-jira-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with jira](#beginning-with-jira)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description
 This module was built with puppet 6 in mind, it would install jira-software based binary package on a Centos07 based linux Physical or virtual machine. Might work with similar RedHat derivatives.
## Setup
Puppet-Jira:
Puppet components have been identified for the masterless to be 

* puppet-agent
* puppet-client-tools
* pdk, (optional) as it comes with the other two above.

This needs your to install ‘epel-release’, the latter may need the following 
Rpm to be installed:

‘’’
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 

‘’’ 

Vagrant-config:

This is essential for this task, to start with an environment that can implement the needed tasks and that is fully prepared, certain components need to be installed and setup correctly.

Vagrantfile:

```
Vagrant.configure("2") do |config|
config.vm.box = "bento/centos-7.5"
config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1",id:"Jira_portal"
config.vm.network "forwarded_port", guest: 8005, host: 8005, host_ip: "127.0.0.1",id:"jira_control"
config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
config.vm.provision "shell",
  inline:"sudo yum -y install epel-release open-vm-tools java-1.8.0-openjdk java-1.8.0-openjdk-devel perl gcc fuse make kernel-devel net-tools policycoreutils-python wget curl http://yum.puppetlabs.com/puppet6/puppet6-release-el-7.noarch.rpm"

config.vm.provision "shell",
  inline: "sudo yum -y install vim puppet-agent puppet-client-tools pdk"
config.vm.provision "shell",
  inline: "sudo yum -y localinstall /vagrant/mysql-connector-java-8.0.15-1.el7.noarch.rpm"
  end


```

Jira files where copied over to the Vagrantfile folder, named Puppetserver-jira:

The purpose was to ensure that this vagrant instance would mount the folder /vagrant with the JIra components with it, thus one will not need to setup a git or https server to pull components from!

$ vagrant plugin install vagrant-vbguest

### What jira affects **OPTIONAL**

 It would install on '/opt/atlassian/{jira-home,jira} Uses open-JDK only on this version 8.x and above, best to check OpenJdk compatibility list.
If there's more that they should know about, though, this is the place to mention:
On most Centos systems its preferred to have a systemd controlled service, the example config is as below:
```
[Unit]
Description=JIRA Service
After=network.target iptables.service firewalld.service firewalld.service httpd.service

[Service]
Type=forking
User=jira
Environment=JRE_HOME=/usr/java/jdk1.8.0_74
ExecStart=/opt/jira710/bin/start-jira.sh
ExecStop=/opt/jira710/bin/stop-jira.sh
ExecReload=/opt/jira710/bin/stop-jira.sh | sleep 60 | /opt/jira710/bin/start-jira.sh

[Install]

WantedBy=multi-user.target

```

Minor point for productions systems if using 'Mysql/MariaDB':
```
[Unit]
Description=JIRA Service
After=network.target iptables.service firewalld.service firewalld.service httpd.service mariadb.service
```


### Setup requirements

Mysql connector was downloaded and moved voia the puppet file resource to the location of 'lib' within the 'jira' install locaiton at, '/opt/atlassian/jira/lib':


Example of the file that controls the DB-connection:
This file resides inside this location: "/var/atlassian/application-data/jira/dbconfig.xml", on a live system
```
<?xml version="1.0" encoding="UTF-8"?>

<jira-database-config>
  <name>defaultDS</name>
  <delegator-name>default</delegator-name>
  <database-type>mysql57</database-type>
  <jdbc-datasource>
    <url>jdbc:mysql://address=(protocol=tcp)(host=<%= lookup('jira::dbhost') -%>)(port=3306)/<%= lookup('jira::pdbname') -%>?sessionVariables=default_storage_engine=InnoDB</url>
    <driver-class>com.mysql.jdbc.Driver</driver-class>
    <username><%= lookup('jira::adminuser') -%></username>
    <password><%= lookup('jira::adminpassword') -%></password>
    <pool-min-size>20</pool-min-size>
    <pool-max-size>20</pool-max-size>
    <pool-max-wait>30000</pool-max-wait>
    <validation-query>select 1</validation-query>
    <min-evictable-idle-time-millis>60000</min-evictable-idle-time-millis>
    <time-between-eviction-runs-millis>300000</time-between-eviction-runs-millis>
    <pool-max-idle>20</pool-max-idle>
    <pool-remove-abandoned>true</pool-remove-abandoned>
    <pool-remove-abandoned-timeout>300</pool-remove-abandoned-timeout>
    <pool-test-on-borrow>false</pool-test-on-borrow>
    <pool-test-while-idle>true</pool-test-while-idle>
    <validation-query-timeout>3</validation-query-timeout>
  </jdbc-datasource>
</jira-database-config>

```

### Beginning with jira

 Port where forwarded to reflect Jira contents on the local host for a vagrant test purpose. Make any changes needed to reflect different needs.

## Usage
 The binary install will allow for /etc/init.d/jira (start|stop) for the service. The script could be extended to incorporate settings for 'systemd'

 
## Reference
 Please consult with the latest jira documents at Atlassian's website.

## Development

contributing to this code will be based upon required change of task specificaiton.
## Release Notes/Contributors/Etc. **Optional**

Built to certain specification can be modified as needed.
