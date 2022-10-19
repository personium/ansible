# Ansible setup instruction

-------------------------------------------------

## Introduction

This is the setup document to launch Personium unit by ansible. Part 1 (Initial Configuration) must be completed, where Part 2 (Tuning Personium) modification is optional, based on the developers requirement.

Below are the files where modification is required.


### Part 1 : Initial Configuration :white_check_mark:

* **Items to be set initially**
* all elements inside `/static_inventory/hosts` file enclosed with `{}`, replace with the constructed server configuration.
* Example

```yaml
    master_token={Master_Token}

    # should be changed to

    master_token=abc123
```

* Modify the hosts file as per instruction below

#### Common Server Setting

```yaml
{Master_Token}
# -> To authorize all kind of operation, set the master token (Strictly managed)
# EX: {Master_Token}->abc123

{Personium_FQDN}
# -> Specify the FQDN for Personium server(same as unit FQDN)
# EX: {Personium_FQDN}->all-in-one.example

{Path_Based_Cell_Url_Enabled}
# -> URL format to access cell*1
# -> true:path based cell url
# -> false:per cell fqdn url
# EX: {Path_Based_Cell_Url_Enabled}->false
```
*1.For explanation about URL format to access cell, please confirm [here](https://personium.io/docs/ja/server-operator/setup_percell.html).

### Part 2 (Tuning Personium) :white_check_mark:

* **Item to be set upon ansible execution(File destination : /group_vars/[group name].yml)**
* As an option, changing the recorded values of all .yml files under group_vars directory is possible. But basically, no modification is required unless server tuning is necessary.
* By specifying the git branch name of personium_core and personium_engine in /group_vars/bastion.yml, you can build by specifying the version of Personium.(Default is master)

#### Web server (file destination : /group_vars/web.yml)

```yaml
  tag_ServerType: web

  nginx_version: 1.14.2

  nginx_hm_version: 0.33
```

#### AP server (file destination : /group_vars/ap.yml)

```yaml
  tag_ServerType: ap

  tomcat_xms: 512m

  tomcat_xmx: 512m

  tomcat_metaspace_size: 256m

  tomcat_max_metaspace_size: 256m

  lock_host: 127.0.0.1

  lock_port: 11211

  cache_host: 127.0.0.1

  cache_port: 11212

  cache_manager: memcached

  tomcat_version: 9.0.27

  commons_daemon_version : 1.2.2

  activemq_version: 5.15.8
```

#### ES server (file destination : /group_vars/es.yml)

```yaml
  tag_ServerType: es

  version: 6.6.1

  es_heapsize: 1875
```

#### NFS server (file destination : /group_vars/nfs.yml)

```yaml
  tag_ServerType: nfs
  
  memcached_version: 1.5.12

  memcached_lock_maxconn: 256

  memcached_cache_maxconn: 256

  # lock / cache instance
  cache_in_nfs: true

  lock_port: 11211

  cache_port: 11212

  # memcached cachesize
  memcached_lock_cachesize: 512

  memcached_cache_cachesize: 512
```

#### Bastion server (file destination : /group_vars/bastion.yml)

```yaml
  tag_ServerType: bastion

  personium_core_version : master

  personium_engine_version : master

```

## Summary

In this document we tried to explain what are the file we require you to modify before executing ansible and build Personium unit. Please use this document as reference.
