#!/bin/sh
set -eu


# Read netcup API secret if not set
NETCUP_API_SECRET="${NETCUP_API_SECRET:-}"
if test -z "$NETCUP_API_SECRET"; then
    # Loop until the secret is entered (necessary if the user attaches to the container later)
    while true; do
        printf "?> Paste the netcup API secret: "
        if read -t 5 -s NETCUP_API_SECRET; then
            echo
            break
        fi
        echo
    done
fi


# Export the netcup creds
export NC_CID="$NETCUP_USER"
export NC_Apikey="$NETCUP_API_KEYID"
export NC_Apipw="$NETCUP_API_SECRET"


# Build domain string
DOMAIN_STRING=""
for INDEX in `seq 1 1024`; do
    # Get the next domain
    DOMAIN=`echo "$DOMAINS" | cut -d "," -f "$INDEX"`
    if test -z "$DOMAIN"; then
        break
    fi

    # Append domain
    DOMAIN_STRING="$DOMAIN_STRING --domain $DOMAIN"
done


# Request cerfificate
echo "*> Issuing certificates for $DOMAINS..."
acme.sh --issue \
    --keylength 4096 \
    --server "$DIRECTORY" \
    --dnssleep 900 \
    --dns dns_netcup \
    $DOMAIN_STRING


# Export the certificate
echo "*> Exporting certificate and key..."
acme.sh --install-cert \
    --key-file /var/certs/tls.key.pem \
    --fullchain-file /var/certs/tls.crt.pem \
    $DOMAIN_STRING
cat < /var/certs/tls.key.pem > /var/certs/tls.haproxy.pem
cat < /var/certs/tls.crt.pem >> /var/certs/tls.haproxy.pem


# All done
echo "acmesh.done" > /var/certs/acmesh.done
echo "*> Done."
