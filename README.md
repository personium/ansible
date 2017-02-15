# Getting Started with Personium using Ansible
-------------------------------

## Overview

The purpose of this document is to explain high level specification for constructing personium.io unit using ansible. If you're curious about ansible, please also read the [HOW ANSIBLE WORKS](http://www.ansible.com/how-ansible-works) page.

### personium.io unit structure

Personium.io unit is configurable based on different purpose of usages like evaluation, development, verification, production etc.. personium.io is provisioning the unit setup tool, for the easiness of the developer to construct personium.io unit automatically based on their needs.
Although you may construct the personium.io unit without using the setup tool, but it is recommended to use the setup tool for constructing the personium.io unit easily.

### Server architecture for personium.io unit
  Personium.io unit construction requires to assign the combination of following 7 roles on a single or multiple interconnected servers properly.


| **Role**     | **Usage**        | **definition**                                                                         |
|:-------------|:-----------------|:---------------------------------------------------------------------------------------|
| `Web`        |  Required        | Reverse proxy server, contains Global IP and also should be accessible to the internet |
| `AP`         |  Required        | Application server, where personium.io will be executed                                |
| `ES`         |  Required        | server to operate `ElasticSearch`                                                      |
| `NFS`        |  Required        | server to operate `Network File System (NFS)`.                                         |
| `Bastion`    |  Optional        | Bastion server. Used to execute ansible and to connect other servers by ssh.           |


### personium.io setup tool

This setup tool will install middleware and configure the OS and its network on your machine (linux server or virtual machine on windows/mac) before installing personium.io module.
There are different patterns of setup tools to construct the personium.io unit. Please select the setup tool based on you purpose.

#### Pattern-1 : Evaluation

If interested, you may try to construct personium.io unit on your local machine (virtualbox) as a separate project using the setup tool.

* Please refer to setup-vagrant: https://github.com/personium/setup-vagrant/

#### Pattern-2 : Development, Verification

* Machine environment : **Linux**
* The number of personium.io unit servers : **1 Server**
  * Server-1 elements : Bastion, Web, AP, ES
* Setup time : 1 hour
* Setup tool: [setup-ansible/1-server_unit](https://github.com/personium/setup-ansible/tree/master/1-server_unit "1-server_unit")
* Note  
  If you are more curious about personium.io and want to develop some simple applications or to test this system, you can select this pattern. You will get personium.io unit on a single server.

#### Pattern-3 : Production

* Machine environment : **Linux**
* The number of personium.io unit servers : **3 Servers**
  * Server-1 elements : Bastion,Web
  * Server-2 elements : AP,NFS
  * Server-3 elements : ES
* Setup time :  2 hours
* Setup tool: [setup-ansible/4-server_unit](https://github.com/personium/setup-ansible/tree/master/3-server_unit "4-server_unit")
* Note  
  If you are devoted to personium.io and want to release some marvelous applications with it, you should try this pattern! You will get personium.io unit with 4 servers, which will meet practical performance.


This document introduced pattern based initial requirements to construct the personium.io unit. Please choose the right pattern that suits your purpose.
Please go thru with other documents to learn about the process to construct the personium.io unit.
