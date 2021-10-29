#!/bin/bash

if [ ! -e '/usr/local/vesta/conf/vesta.conf' ]; then
    exit 0
fi

source /etc/profile.d/vesta.sh
source /usr/local/vesta/func/main.sh
source /usr/local/vesta/conf/vesta.conf

STARTVERSION=$(echo $VERSION)

NEWRELEASE=""

if [ "$VERSION" = "0.9.8" ]; then
    #Convert to made I.T.
    bash /usr/local/vesta/upd/add_ipv6.sh
    VERSION="0.0.1"
    sed -i "s/VERSION=.*/VERSION='0.0.1'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.1" ]; then
    VERSION="0.0.2"
    sed -i "s/VERSION=.*/VERSION='0.0.2'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.2" ]; then
    VERSION="0.0.3"
    sed -i "s/VERSION=.*/VERSION='0.0.3'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.3" ]; then
    bash /usr/local/vesta/upd/add_mail_ssl.sh
    VERSION="0.0.4"
    sed -i "s/VERSION=.*/VERSION='0.0.4'/g" /usr/local/vesta/conf/vesta.conf
    
    
    $BIN/v-update-web-templates
    userlist=$(ls --sort=time $VESTA/data/users/)
    for user in $userlist; do
        $BIN/v-rebuild-user $user
    done
fi

if [ "$VERSION" = "0.0.4" ]; then
    bash /usr/local/vesta/upd/add_mail_ssl.sh
    VERSION="0.0.5"
    sed -i "s/VERSION=.*/VERSION='0.0.5'/g" /usr/local/vesta/conf/vesta.conf
    
    bash /usr/local/vesta/upd/separate_web_conf.sh
fi

if [ "$VERSION" = "0.0.5" ]; then
    VERSION="0.0.6"
    sed -i "s/VERSION=.*/VERSION='0.0.6'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.6" ]; then
    VERSION="0.0.7"
    sed -i "s/VERSION=.*/VERSION='0.0.7'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.7" ]; then
    VERSION="0.0.8"
    sed -i "s/VERSION=.*/VERSION='0.0.8'/g" /usr/local/vesta/conf/vesta.conf

    #Fix not changed templates
    userlist=$(ls --sort=time $VESTA/data/users/)
    for user in $userlist; do
        $BIN/v-rebuild-web-domains $user
    done
fi

if [ "$VERSION" = "0.0.8" ]; then
    VERSION="0.0.9"
    sed -i "s/VERSION=.*/VERSION='0.0.9'/g" /usr/local/vesta/conf/vesta.conf

    /usr/local/vesta/bin/v-rebuild-config-logrotate
    /usr/local/vesta/bin/v-update-dns-templates
    /usr/local/vesta/bin/v-update-web-templates
    
    userlist=$(ls --sort=time $VESTA/data/users/)
    for user in $userlist; do
        $BIN/v-rebuild-dns-domains $user
        $BIN/v-rebuild-web-domains $user
    done
fi

if [ "$VERSION" = "0.0.9" ]; then
    VERSION="0.0.10"
    sed -i "s/VERSION=.*/VERSION='0.0.10'/g" /usr/local/vesta/conf/vesta.conf
    bash /usr/local/vesta/upd/fix_roundcube.sh
    
    #UPDATE BACKUP HOSTS
    files=$(ls /usr/local/vesta/ | grep backup.conf)
    for file in $files; do
        conf="/usr/local/vesta/$file"
        while read line ; do
            eval $line
            if [ "$(echo $line | grep 'ROTATE=')" == "" ]; then
                sed -i "s/TIME='$TIME' DATE='$DATE'/ROTATE='yes' TIME='$TIME' DATE='$DATE'/g" "$conf"
            fi
        done < $conf
    done
fi

if [ "$VERSION" = "0.0.10" ]; then
    VERSION="0.0.11"
    sed -i "s/VERSION=.*/VERSION='0.0.11'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.11" ]; then
    VERSION="0.0.12"
    sed -i "s/VERSION=.*/VERSION='0.0.12'/g" /usr/local/vesta/conf/vesta.conf
    
    bash /usr/local/vesta/upd/fix_dhcprenew.sh
    bash /usr/local/vesta/upd/limit_sudo.sh
fi


if [ "$VERSION" = "0.0.12" ]; then
    VERSION="0.0.13"
    sed -i "s/VERSION=.*/VERSION='0.0.13'/g" /usr/local/vesta/conf/vesta.conf
    
    bash /usr/local/vesta/upd/fix_nologinShell.sh
    bash /usr/local/vesta/upd/add_custom_docroot.sh
    bash /usr/local/vesta/upd/fix_httpd_permission.sh
    
    #Disable API by default
    if [ "$(grep 'API=' /usr/local/vesta/conf/vesta.conf)" == "" ]; then
        echo "API='no'" >> /usr/local/vesta/conf/vesta.conf
    fi
    
    #UPDATE BACKUP HOSTS
    files=$(ls /usr/local/vesta/ | grep backup.conf)
    for file in $files; do
        conf="/usr/local/vesta/$file"
        while read line ; do
            eval $line
            if [ "$(echo $line | grep 'ROTATE=')" == "" ]; then
                sed -i "s/TIME='$TIME' DATE='$DATE'/ROTATE='yes' TIME='$TIME' DATE='$DATE'/g" "$conf"
            fi
        done < $conf
    done
fi

if [ "$VERSION" = "0.0.13" ]; then
    VERSION="0.0.14"
    sed -i "s/VERSION=.*/VERSION='0.0.14'/g" /usr/local/vesta/conf/vesta.conf
    
    echo "Run script /usr/local/vesta/bin/v-update-web-templates"
fi

if [ "$VERSION" = "0.0.14" ]; then
    VERSION="0.0.15"
    sed -i "s/VERSION=.*/VERSION='0.0.15'/g" /usr/local/vesta/conf/vesta.conf
    
    echo "Run script /usr/local/vesta/bin/v-update-web-templates"
fi

if [ "$VERSION" = "0.0.15" ]; then
    VERSION="0.0.16"
    sed -i "s/VERSION=.*/VERSION='0.0.16'/g" /usr/local/vesta/conf/vesta.conf
    
    bash /usr/local/vesta/upd/fix_docroot.sh
fi

if [ "$VERSION" = "0.0.16" ]; then
    VERSION="0.0.17"
    sed -i "s/VERSION=.*/VERSION='0.0.17'/g" /usr/local/vesta/conf/vesta.conf
    
    if [ "$FIREWALL_EXTENSION" = 'fail2ban' ]; then
        bash /usr/local/vesta/bin/v-rebuild-config-fail2ban
    fi
    
    if [ "$PROXY_SYSTEM" = 'nginx' ]; then
        bash /usr/local/vesta/upd/update_nginx_extensions.sh
    fi
fi

if [ "$VERSION" = "0.0.17" ]; then
    VERSION="0.0.18"
    sed -i "s/VERSION=.*/VERSION='0.0.18'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.18" ]; then
    VERSION="0.0.19"
    sed -i "s/VERSION=.*/VERSION='0.0.19'/g" /usr/local/vesta/conf/vesta.conf
    
    NEWRELEASE="$NEWRELEASE \n Wanna upgrade your MySQL from 5.5 to  MariaDB 10.4 server? Run 'bash /usr/local/vesta/upd/upgrade_mysql.sh'"
fi

if [ "$VERSION" = "0.0.19" ]; then
    VERSION="0.0.20"
    sed -i "s/VERSION=.*/VERSION='0.0.20'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.20" ]; then
    #Fix e-mail of cronjob
    sed -i "s|v-notify-sys-status'|v-notify-sys-status > /dev/null'|g" $VESTA/data/users/admin/cron.conf
    $VESTA/bin/v-rebuild-cron-jobs admin
    
    VERSION="0.0.21"
    sed -i "s/VERSION=.*/VERSION='0.0.21'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.21" ]; then
    VERSION="0.0.22"
    sed -i "s/VERSION=.*/VERSION='0.0.22'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.22" ]; then
    VERSION="0.0.23"
    bash /usr/local/vesta/bin/v-rebuild-config-exim
    bash /usr/local/vesta/bin/v-rebuild-config-fail2ban
    sed -i "s/VERSION=.*/VERSION='0.0.23'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.23" ]; then
    VERSION="0.0.24"
    bash /usr/local/vesta/bin/v-rebuild-config-exim
    sed -i "s/VERSION=.*/VERSION='0.0.24'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.24" ]; then
    VERSION="0.0.25"
    bash /usr/local/vesta/bin/fix_httpd_permission.sh
    bash /usr/local/vesta/bin/fix_backup_rotation.sh
    bash /usr/local/vesta/bin/v-rebuild-config-exim
    sed -i "s/VERSION=.*/VERSION='0.0.25'/g" /usr/local/vesta/conf/vesta.conf
    
    NEWRELEASE="$NEWRELEASE \n This version adds a beta plugin system to your control panel! Read more on https://www.tpweb.org"
fi

if [ "$VERSION" = "0.0.25" ]; then
    VERSION="0.0.26"
    bash /usr/local/vesta/bin/fix_httpd_permission.sh
    sed -i "s/VERSION=.*/VERSION='0.0.26'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.26" ]; then
    VERSION="0.0.27"
    bash /usr/local/vesta/bin/fix_httpd_permission.sh
    sed -i "s/VERSION=.*/VERSION='0.0.27'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.27" ]; then
    VERSION="0.0.28"
    bash /usr/local/vesta/bin/fix_httpd_permission.sh
    bash /usr/local/vesta/bin/v-rebuild-config-exim
    sed -i "s/VERSION=.*/VERSION='0.0.28'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.28" ]; then
    VERSION="0.0.29"
    sed -i "s/VERSION=.*/VERSION='0.0.29'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.29" ]; then
    VERSION="0.0.30"
    sed -i "s/VERSION=.*/VERSION='0.0.30'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.30" ]; then
    VERSION="0.0.31"
    sed -i "s/VERSION=.*/VERSION='0.0.31'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.31" ]; then
    VERSION="0.0.32"
    bash /usr/local/vesta/bin/v-rebuild-config-fail2ban
    
    mkdir -p /etc/nginx/certs
    wget -O /etc/nginx/certs/lets-encrypt-x3-cross-signed.pem "https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem" > /dev/null 
    if [ $? -eq 0 ]; then
        sed -i "s/#ssl_trusted_certificate/ssl_trusted_certificate/g" /etc/nginx/nginx.conf
    fi
    openssl dhparam -out /etc/nginx/certs/dhparam.pem 4096 > /dev/null 
    if [ $? -eq 0 ]; then
        sed -i "s/#ssl_dhparam/ssl_dhparam/g" /etc/nginx/nginx.conf
    fi
    
    /usr/local/vesta/bin/v-rebuild-config-nginx
    /usr/local/vesta/bin/v-update-web-templates
    
    NEWRELEASE="$NEWRELEASE \n This version improved WordPress fail2ban integration. By using the wp-fail2ban plugin (https://wordpress.org/plugins/wp-fail2ban/)."
    sed -i "s/VERSION=.*/VERSION='0.0.32'/g" /usr/local/vesta/conf/vesta.conf
fi

if [ "$VERSION" = "0.0.32" ]; then
    VERSION="0.0.34"
    /usr/local/vesta/bin/v-update-web-templates
    sed -i "s/VERSION=.*/VERSION='0.0.34'/g" /usr/local/vesta/conf/vesta.conf
fi


if [ -z "$(grep "v-notify-sys-status" $VESTA/data/users/admin/cron.conf)" ]; then
    command="sudo $VESTA/bin/v-notify-sys-status > /dev/null"
    
    min=$(generate_password '012345' '2')
    hour=$(generate_password '1234567' '1')
    $VESTA/bin/v-add-cron-job 'admin' "$min" "$hour" '*' '*' '*' "$command" 
fi

bash /usr/local/vesta/upd/add_default_plugins.sh
$VESTA/bin/v-add-cron-vesta-autoupdate

#Send update e-mail to admin
tmpfile=$(mktemp -p /tmp)
email=$($VESTA/bin/v-list-user admin | grep EMAIL: | awk '{print $2}')
echo -e "Congratulations, you have just successfully updated \
Vesta Control Panel by Made I.T.

Server: $(hostname)
Previous Version: $STARTVERSION
New Version: $VERSION
$NEWRELEASE


We hope that you enjoy your installation of Vesta. Please \
feel free to contact us anytime if you have any questions.

Support: https://github.com/madeITBelgium/vesta

--
Sincerely yours
madeit.be team
" > $tmpfile

send_mail="$VESTA/web/inc/mail-wrapper.php"
cat $tmpfile | $send_mail -s "Vesta Control Panel" $email


echo '======================================================='
echo
echo ' _|      _|  _|_|_|_|    _|_|_|  _|_|_|_|_|    _|_|   '
echo ' _|      _|  _|        _|            _|      _|    _| '
echo ' _|      _|  _|_|_|      _|_|        _|      _|_|_|_| '
echo '   _|  _|    _|              _|      _|      _|    _| '
echo '     _|      _|_|_|_|  _|_|_|        _|      _|    _| '
echo
echo
cat $tmpfile
rm -f $tmpfile
