# Getting Started with Personium using Ansible
-------------------------------

## Overview

The purpose of this document is to explain high level specification for constructing Personium unit using ansible. If you're curious about ansible, please also read the [HOW ANSIBLE WORKS](http://www.ansible.com/how-ansible-works) page.

### Personium unit structure

Personium unit is configurable based on different purpose of usages like evaluation, development, verification, production etc.. Personium is provisioning the unit setup tool, for the easiness of the developer to construct Personium unit automatically based on their needs.
Although you may construct the Personium unit without using the setup tool, but it is recommended to use the setup tool for constructing the Personium unit easily.

### Server architecture for Personium unit
  Personium unit construction requires to assign the combination of following 7 roles on a single or multiple interconnected servers properly.


| **Role**     | **Usage**        | **definition**                                                                         |
|:-------------|:-----------------|:---------------------------------------------------------------------------------------|
| `Web`        |  Required        | Reverse proxy server, contains Global IP and also should be accessible to the internet |
| `AP`         |  Required        | Application server, where Personium will be executed                                |
| `ES`         |  Required        | server to operate `ElasticSearch`                                                      |
| `MQ`         |  Required        | server to operate `Message Queue`.|
| `NFS`        |  Required        | server to operate `Network File System (NFS)`.                                         |
| `Bastion`    |  Optional        | Bastion server. Used to execute ansible and to connect other servers by ssh.           |


### Personium setup tool

This setup tool will install middleware and configure the OS and its network on your machine (linux server or virtual machine on windows/mac) before installing Personium module.
There are different patterns of setup tools to construct the Personium unit. Please select the setup tool based on you purpose.

#### Pattern-1 : all-in-one

* Machine environment : **CentOS 7**
* The number of Personium unit servers : **1 Server**
  * Server-1 elements : Bastion, Web, AP, ES
* Setup time : 1 hour
* Setup tool: [ansible/all-in-one](./all-in-one "all-in-one").  
* Note  
  If you are more curious about Personium and want to develop some simple applications or to test this system, you can select this pattern. You will get Personium unit on a single server.

\* By using Vagrant it is possible to easily build a virtual machine in the local machine environment and check the operation of Personium.  
For the setting procedure, please refer to [setup-vagrant](https://github.com/personium/setup-vagrant).

#### Pattern-2 : 3-tier

* Machine environment : **CentOS 7**
* The number of Personium unit servers : **4 Servers**
  * Server-1 elements : Bastion
  * Server-2 elements : Web
  * Server-3 elements : AP,NFS
  * Server-4 elements : ES
* Setup time :  2 hours
* Setup tool: [ansible/3-tier](./3-tier "3-tier").  
* Note  
  If you are devoted to Personium and want to release some marvelous applications with it, you should try this pattern! You will get Personium unit with 3-tier, which will meet practical performance.


#### Middleware on VM

* Middleware  

    |Category       | Name           |Version       |                   |
    |:--------------|:---------------|-------------:|:------------------|
    | java          | AdoptOpenJDK   |        8u192 | --                |
    | tomcat        | tomcat         |       9.0.27 | web               |
    |               | commons-daemon |        1.1.0 | --                |
    | activemq      | activemq       |       5.15.8 | --                |
    | nginx         | nginx          |       1.14.2 | proxy             |
    |               | Headers More   |         0.33 | --                |
    | logback       | logback        |        1.2.3 | --                |
    |               | slf4j          |        1.6.4 | --                |
    | memcached     | memcached      |       1.5.12 | cache             |
    | elasticsearch | elasticsearch  |        6.6.1 | db & search engine|

This document introduced pattern based initial requirements to construct the Personium unit. Please choose the right pattern that suits your purpose.
Please go thru with other documents to learn about the process to construct the Personium unit.
