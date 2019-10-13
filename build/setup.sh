#!/usr/bin/env bash


/sbin/setuser app touch /home/app/.ssh/authorized_keys

# Add fix_www_permissions to corn
echo '0 * * * * root fix_app_permissions >/dev/null 2>&1' >> /etc/crontab