# Certificate creation using Let's Encrypt.

-------------------------------------------------

## Introduction.

Describe how to create and use certificates by certificate authorities.
This procedure describes how to create a server certificate using [Let's Encrypt](https://letsencrypt.org/). When using another certificate authority, please create it according to the procedure provided by your certificate authority.

### Confirmed environment.

The operation is confirmed in the following environment in the procedure.

| | Version      |
|:--------|:-----|
| CentOS  | 7.2  |
| Certbot | 0.27 |

### Part 1 : Installation of certbot.

Install `certbot` using the yum command.

```console
# yum install -y epel-release
# yum install -y certbot
```

### Part 2 : Creating a server certificate using Certbot.

Create a server certificate using certbot.
\* This procedure is working interactively.

1. Execute the following command to start certificate creation processing by certbot.

    ```console
    # certbot certonly --domain {FQDN} --domain "*.{FQDN}" --manual --preferred-challenges dns
    ```

1. Register your email address in Let's Encrypt.

    ```console
    Saving debug log to /var/log/letsencrypt/letsencrypt.log
    Plugins selected: Authenticator manual, Installer None
    Enter email address (used for urgent renewal and security notices) (Enter 'c' to
    cancel):{mail address}
    ```

1. I will review the terms of use and agree to the terms of service.

    ```console
    Starting new HTTPS connection (1): acme-v02.api.letsencrypt.org

    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Please read the Terms of Service at
    https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
    agree in order to register with the ACME server at
    https://acme-v02.api.letsencrypt.org/directory
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    (A)gree/(C)ancel: A
    ```

1. We will respond to information availability from Let's Encrypt.
    \* Please answer "Y" or "N" as necessary.

    ```console
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Would you be willing to share your email address with the Electronic Frontier
    Foundation, a founding partner of the Let's Encrypt project and the non-profit
    organization that develops Certbot? We'd like to send you email about our work
    encrypting the web, EFF news, campaigns, and ways to support digital freedom.
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    (Y)es/(N)o: N
    ```

1. We will respond to questions about global IP address storage availability.

    ```console
    Obtaining a new certificate
    Performing the following challenges:
    dns-01 challenge for {FQDN}

    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    NOTE: The IP of this machine will be publicly logged as having requested this
    certificate. If you're running certbot in manual mode on a machine that is not
    your server, please ensure you're okay with that.

    Are you OK with your IP being logged?
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    (Y)es/(N)o: Y
    ```

1. Follow the instructions and register the TXT record in the DNS server that manages the domain.

    ```console
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Please deploy a DNS TXT record under the name
    _acme-challenge.{FQDN} with the following value:

    cue8r-99XuwWtmRhJqZeEpB4F1szNr4BH17qot_kX9g

    Before continuing, verify the record is deployed.
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ```

1. Follow the instructions and register the TXT record in the DNS server that manages the domain, again.

    ```console
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Please deploy a DNS TXT record under the name
    _acme-challenge.{FQDN} with the following value:

    8pDJZ1pCXmhh-OHSaV2IM_dLztGk31AnQytk1MJhx9E

    Before continuing, verify the record is deployed.
    (This must be set up in addition to the previous challenges; do not remove,
    replace, or undo the previous challenge tasks yet. Note that you might be
    asked to create multiple distinct TXT records with the same name. This is
    permitted by DNS standards.)
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ```

1. When registration of TXT record is completed and you can refer to it from the Internet, press "Enter" key.
    \* It may take time depending on DNS service specification until TXT record can be registered correctly and it can be referred from the Internet.

    ```console
    Press Enter to Continue
    ```

    The certificate creation process starts.

    ```console
    Waiting for verification...
    Resetting dropped connection: acme-v02.api.letsencrypt.org
    Resetting dropped connection: acme-v02.api.letsencrypt.org
    Cleaning up challenges

    IMPORTANT NOTES:
        - Congratulations! Your certificate and chain have been saved at:
        /etc/letsencrypt/live/{FQDN}/fullchain.pem
        Your key file has been saved at:
        /etc/letsencrypt/live/{FQDN}/privkey.pem
        Your cert will expire on 2019-01-23. To obtain a new or tweaked
        version of this certificate in the future, simply run certbot
        again. To non-interactively renew *all* of your certificates, run
        "certbot renew"
        - If you like Certbot, please consider supporting our work by:

        Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
        Donating to EFF:                    https://eff.org/donate-le
    ```

1. Confirm that the file was created with the following command.

    ```console
    # ls -l /etc/letsencrypt/live/{FQDN}/
    ```

    | FileName       | Description              |
    |:---------------|:-------------------------|
    | privkey.pem    | Private key              |
    | cert.pem       | Server Certificate       |
    | chain.pem      | Intermediate Certificate |
    | fullchain.pem  | Server certificate including Intermediate certificate  |

### Part 3 : Registering the created certificate.

Execute the following command and save the certificate in the material directory to be distributed by ansible.

```console
# cp /etc/letsencrypt/live/{FQDN}/fullchain.pem $ansible/resource/web/opt/nginx/conf/server.crt
# cp /etc/letsencrypt/live/{FQDN}/privkey.pem $ansible/resource/web/opt/nginx/conf/server.key
```
