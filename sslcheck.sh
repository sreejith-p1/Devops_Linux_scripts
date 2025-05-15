#!/bin/bash
DOMAIN="example.com"
EXPIRY_DATE=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)
EXPIRY_SECONDS=$(date --date="$EXPIRY_DATE" +%s)
NOW_SECONDS=$(date +%s)
DAYS_LEFT=$(( ($EXPIRY_SECONDS - $NOW_SECONDS) / 86400 ))
echo "$DOMAIN SSL certificate expires in $DAYS_LEFT days"
