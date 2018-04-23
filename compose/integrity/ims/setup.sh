#!/bin/sh
set -x

SED_DB_DATABASE=${DB_DATABASE:-imsdb} 
SED_DB_HOST=${DB_HOST:-db-host} 
SED_DB_PORT=${DB_PORT:-3306}    
SED_DB_USER=${DB_USER:-aceims} 
SED_DB_PASSWORD=${DB_PASSWORD:-ace}
SED_SMTP_HOST=${SMTP_HOST:-smtp.gmail.com:587}
SED_SMTP_TLS=${SMTP_TLS:-true}
SED_SMTP_FROM=${SMTP_FROM:-dockertestfilesender@gmail.com}
SED_SMTP_USER=${SMTP_USER:-dockertestfilesender}
SED_SMTP_PASSWORD=${SMTP_PASSWORD:-password=\"thisisalongpassword\"}

cat /opt/ace-ims/opt.payara5.glassfish.domains.domain1.config.domain.xml | \
sed -e "s/__DB_USER__/$SED_DB_USER/g" \
    -e "s/__DB_PASSWORD__/$SED_DB_PASSWORD/g" \
    -e "s/__DB_DATABASE__/$SED_DB_DATABASE/g" \
    -e "s/__DB_HOST__/$SED_DB_HOST/g" \
    -e "s/__DB_PORT__/$SED_DB_PORT/g" \
    -e "s/__SMTP_HOST__/$SED_SMTP_HOST/g" \
    -e "s/__SMTP_TLS__/$SED_SMTP_TLS/g" \
    -e "s/__SMTP_FROM__/$SED_SMTP_FROM/g" \
    -e "s/__SMTP_USER__/$SED_SMTP_USER/g" \
    -e "s/__SMTP_PASSWORD__/$SED_SMTP_PASSWORD/g" \
> ${PAYARA_PATH}/glassfish/domains/domain1/config/domain.xml

if [ "xx${BOOTSTRAP_SLEEP}" != "xx" ]; then
  sleep $BOOTSTRAP_SLEEP
fi

mv -v ${PAYARA_PATH}/deployments/* ${PAYARA_PATH}/glassfish/domains/domain1/autodeploy
