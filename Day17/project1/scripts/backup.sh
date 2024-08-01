#!/bin/bash

mkdir /srv/backups/mysql/

mysqldump -u {{ mysql_user }} -p{{ mysql_user_password }} {{ mysql_db_name }} > {{ backup_dir }}/backup_$(date +\%F).sql