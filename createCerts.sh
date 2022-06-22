#! /bin/bash
rm -rf certs
mkdir -p certs
pushd certs
if [[ ! -z "$1" && $1 == "destroy" ]]
then 
  echo -e '\n*******  Removing all certificate files created by me   *******\n'
  rm -f ./certs
  popd
else
read -p 'Enter Domain Name [FQDN]: ' DOMAINNAME

COUNTRY="IN"
STATE="MH"
LOCALITY="Pune" 
ORGNAME="TIBCO"
ORGUNIT="Connectors"
COMMONNAMEFQDN=$DOMAINNAME
EMAIL="awakchau@tibco.com"

cat <<EOF >server.csr.cnf
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[dn]
C=IN
ST=MH
L=Pune
O=TIBCO
OU=Connectors
emailAddress=awakchau@tibco.com
CN=$DOMAINNAME
EOF

cat <<EOF >v3.ext
authorityKeyIdentifier = keyid,issuer
basicConstraints       = CA:FALSE
keyUsage               = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment, keyAgreement, keyCertSign
subjectAltName         = @alt_names
issuerAltName          = issuer:copy

[alt_names]
DNS.1=$DOMAINNAME
DNS.2=*.$DOMAINNAME
EOF


echo -e '\n*******  STEP 1/4: Creating private key for root CA  *******\n'
openssl genrsa -des3 -out rootCA.key 2048

echo -e '\n*******  STEP 2/4: Creating self signed root CA certificate  *******\n'
cat <<__EOF__ | openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem
$COUNTRY
$STATE
$LOCALITY
$ORGNAME
$ORGUNIT
$COMMONNAMEFQDN
$EMAIL
__EOF__

echo -e '\n*******  STEP 3/4: Creating private key for creating subordinate CA   *******\n'
openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config <( cat server.csr.cnf )

echo -e '\n*******  STEP 4/4: Creating CSR for subordinate CA   *******\n'
openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 500 -sha256 -extfile v3.ext

rm -f server.csr.cnf v3.ext rootCA.srl server.csr
fi
popd