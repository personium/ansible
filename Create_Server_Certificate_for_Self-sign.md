# Server certificate creation using Self sign

-------------------------------------------------

Following is server self-signed ssl certificate creation procedure.

* Common Name value should be the unit domain name.
* Subject Alternative Name (SAN) values should also be the unit domain name
and wildcard domain name.

```console
    # cd $ansible/resource/web/opt/nginx/conf
    # openssl genrsa -des3 -out server.key 1024
           Enter pass phrase for server.key:                            \* Required (Characters length: is 4 - 8191)
    # openssl req -new -key server.key -out server.csr
           Enter pass phrase for server.key:                            \* enter the value of `server.key`
           Country Name (2 letter code) [XX]:                           \* Optional ( entered value will be visible in the certificate)
           State or Province Name (full name) []:                       \* Optional ( entered value will be visible in the certificate)
           Locality Name (eg, city) [Default City]:                     \* Optional ( entered value will be visible in the certificate)
           Organization Name (eg, company) [Default Company Ltd]:       \* Optional ( entered value will be visible in the certificate)
           Organizational Unit Name (eg, section) []:                   \* Optional ( entered value will be visible in the certificate)
           Common Name (eg, your name or your server's hostname) []:    \* Required ( entered value will be visible in the certificate)
           Email Address []:                                            \* Optional ( entered value will be visible in the certificate)

           Please enter the following 'extra' attributes
           to be sent with your certificate request
           A challenge password []:
           An optional company name []:

    # cp server.key server.key.org
    # openssl rsa -in server.key.org -out server.key
           Enter pass phrase for server.key.org:     \* enter the value of `server.key`
    # echo "subjectAltName = DNS:{FQDN}, DNS:*.{FQDN}" >san.txt         \* Replace {FQDN} with your FQDN
    # openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt -extfile san.txt
    # ls -l server.*
```

* Check if the following files are created
  * server.key.org
  * server.crt
  * server.csr
  * server.key

* Check the certificate content. (Especially CommonName and Subject Alternative Name values.)

```console
# openssl x509 -in server.crt -text | grep Subject -1
            Not After : Oct 15 01:38:40 2020 GMT
        Subject: C=XX, L=Default City, O=Default Company Ltd, CN=test.example
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
--
        X509v3 extensions:
            X509v3 Subject Alternative Name:
                DNS:text.example, DNS:*.test.example
```

* After constructing Personium unit, add the certificate to JRE that runs tomcat in AP server.

```console
# cd ${JAVA_HOME}/jre/lib/security
# cp cacerts{,.org}
# keytool -import -trustcacerts -file /path/to/your/self-signed-certificate -keystore cacerts -alias ca
```
