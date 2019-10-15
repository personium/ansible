# DNS setup for per-cell URL

-------------------------------------------------

## Introduction

Before executing Personium ansible playbook, you need to configure DNS setting
since per-cell URL introduced in personium-core v1.7.6 requires it.

### Per-cell URL

Per-cell URL is represented as:

```
https://{CellName}.{UnitFQDN}/
```

So cell URLs are different per cell and wild card DNS record (like `*.{UnitFQDN}`)
is required in DNS setting. Per-cell URL is configured by setting configuration value of
`pathBasedCellUrl.enabled` to false in `personium-unit-config.properties` and basically
the value is required to set false for security reason.

## DNS setup

You need to configure following DNS setting if you use per-cell URL.

|FQDN|Record type|IP address|
|---|---|---|
|{Personium unit FQDN}|A|{Personium unit global IP address}|
|*.{Personium unit FQDN}|A|{Personium unit global IP address}|

For example, if you use `192.0.2.0` as Personium unit global IP address
and `personium.example` as Personium unit FQDN, DNS records are as followings:

|FQDN|Record type|IP address|
|---|---|---|
|personium.example|A|192.0.2.0|
|*.personium.example|A|192.0.2.0|
