# Ansible setup instruction

-------------------------------------------------

## Introduction

This is the setup document to launch personium unit by ansible. Part 1 (Initial Configuration) must be completed, where Part 2 (Tuning personium) modification is optional, based on the developers requirement.

Below are the files where modification is required.


### Part 1 : Initial Configuration :white_check_mark:

* **Items to be set initially**
* all elements inside `/static_inventory/hosts` file enclosed with `{}`, replace with the constructed server configuration.
* Example

```yaml
    ansible_ssh_user={Ansible_Execution_User}

    # should be changed to

    ansible_ssh_user=root
```

* Modify the hosts file as per instruction below

#### Common Server Setting

```yaml
{Ansible_Execution_User}
# -> Specify a user ansible execution
# EX: {Ansible_Execution_User}->root

{SSH_PrivateKey}
# -> Set the secret key in the absolute path for  ansible user ssh public key authentication
# EX: {SSH_PrivateKey}->root/.ssh/id_rsa
```

#### Bastion server

```yaml
{Bastion_Private_IP}
# -> Specify the private IP of Bastion server
# EX: {Bastion_Private_IP}->172.31.10.248

{Bastion_Tag_Name}
# -> Specify the host name for Bastion server
# EX: {Bastion_Tag_Name}->bastion-web

{Bastion_Network_Separation}
# -> Specify the network catagory for Bastion server
# EX: {Bastion_Network_Separation}->172.31.10.0/24
```

#### Web server

```yaml
{Web_Private_IP}
# -> Specify the private IP of Web server
# EX: {Web_Private_IP}->172.31.10.248

{Web_Tag_Name}
# -> Specify the host name for Web server
# EX: {Web_Tag_Name}->bastion-web

{Web_Global_IP}
# -> Specify the global IP for Web server
# EX: {Web_Global_IP}->54.65.33.203

{Web_FQDN}
# -> Specify the FQDN for Web server(same as unit FQDN)
# EX: {Web_FQDN}->ec2-54-65-33-203.ap-northeast-1.compute.amazonaws.com
```

#### AP server

```yaml
{AP_Private_IP}
# -> Specify the private IP of  AP server
# EX: {AP_Private_IP}->172.31.13.38

{AP_Network_Separation}
# -> Specify the network catagory for AP server
# EX: {AP_Network_Separation}->172.31.13.0/24

{AP_Tag_Name}
# -> Specify the host name for AP server
# EX: {AP_Tag_Name}->test-ap

{Master_Token}
# -> To authorize all kind of operation, set the master token (Strictly managed)
# EX: {Master_Token}->abc123
```

#### ES server

```yaml
{ES_Private_IP}
# -> Set the private IP for ES server
# EX: {ES_Private_IP}->172.31.3.80

{ES_Tag_Name}
# -> Specify the host name for ES server
# EX: {ES_Tag_Name}->test-ES
```

#### NFS server

```yaml
{NFS_Private_IP}
# -> Set the private IP for NFS server
# EX: {NFS_Private_IP}->172.31.13.38

{nfs_Tag_Name}
# -> Specify the host name for nfs server
# EX: {nfs_Tag_Name}->test-NFS
```

### Part 2 (Tuning personium) :white_check_mark:

* **Item to be set upon ansible execution(File destination : /group_vars/[group name].yml)**
* As an option, changing the recorded values of all .yml files under group_vars directory is possible. But basically, no modification is required unless server tuning is necessary.

#### Web server (file destination : /group_vars/web.yml)

```yaml
  tag_ServerType: web

  nginx_version: 1.11.9

  nginx_hm_version: 0.31
```

#### AP server (file destination : /group_vars/ap.yml)

```yaml
  tag_ServerType: ap

  tomcat_version: 8.0.41

  tomcat_xms: 1024m

  tomcat_xmx: 1024m

  tomcat_metaspace_size: 256m

  tomcat_max_metaspace_size: 256m

  commons_daemon_version : 1.0.15

  lock_host: pcs-nfs

  lock_port: 11211

  cache_host: pcs-nfs

  cache_port: 11212

  cache_manager: memcached
```

#### ES server (file destination : /group_vars/es.yml)

```yaml
  tag_ServerType: es

  es_heapsize: 3328

  version: 1.3.4
```

#### NFS server (file destination : /group_vars/nfs.yml)

```yaml
  tag_ServerType: nfs

  # lock / cache instance
  cache_in_nfs: true

  lock_port: 11211

  cache_port: 11212

  # memcached cachesize
  memcached_lock_cachesize: 512

  memcached_cache_cachesize: 512

  memcached_version: 1.4.21

  memcached_lock_maxconn: 1024

  memcached_cache_maxconn: 1024
```

#### bastion server (file destination : /group_vars/bastion.yml)

```yaml
  tag_ServerType: bastion

```

## Summary

In this document we tried to explain what are the file we require you to modify before executing ansible and build personium unit. Please use this document as reference.
