Project 01
======
### Deploy a Database Server with Backup Automation
**Objective:** Automate the deployment and configuration of a PostgreSQL database server on an Ubuntu instance hosted on AWS, and set up regular backups.

#### Problem Statement
**Objective:** Automate the deployment, configuration, and backup of a PostgreSQL database server on an Ubuntu instance using Ansible.

**Requirements:**
1. **AWS Ubuntu Instance:** You have an Ubuntu server instance running on AWS.
2. **Database Server Deployment:** Deploy and configure PostgreSQL on the Ubuntu instance.
3. **Database Initialization:** Create a database and a user with specific permissions.
4. **Backup Automation:** Set up a cron job for regular database backups and ensure that backups are stored in a specified directory.
5. **Configuration Management:** Use Ansible to handle the deployment and configuration, including managing sensitive data like database passwords.

### Deliverables
1. **Ansible Inventory File**
> Filename: inventory.ini

```ini
[target]
ec2-instance ansible_host=000.000.000.000 ansible_user=user ansible_private_key=/path/to/the/private/key.pem
```
- Content: Defines the AWS Ubuntu instance and connection details for Ansible.

![alt text](img/image1.png)

2. **Ansible Playbook**
> Filename: deploy_database.yml

```yml
---
- hosts: all
  become: yes
  vars:
    mysql_root_password: "your_mysql_root_password"
    mysql_db_name: "your_mydatabase"
    mysql_user: "your_user"
    mysql_user_password: "your_user_pass"
    backup_dir: "/srv/backups/mysql"
    cron_time: "0 2 * * *"
 
  tasks:
    - name: Installing Mysql and dependencies
      package:
       name: "{{item}}"
       state: present
       update_cache: yes
      loop:
       - mysql-server
       - mysql-client
       - python3-mysqldb
       - libmysqlclient-dev
 
 
    - name: start and enable mysql service
      service:
        name: mysql
        state: started
        enabled: yes
 
    - name: Set MySQL root password
      mysql_user:
        name: root
        password: "{{ mysql_root_password }}"
        host_all: yes
        state: present
        login_unix_socket: /var/run/mysqld/mysqld.sock
 
    - name: Remove anonymous MySQL user
      mysql_user:
        name: ''
        host: localhost
        state: absent
        login_user: root
        login_password: "{{ mysql_root_password }}"
 
    - name: Remove MySQL test database
      mysql_db:
        name: test
        state: absent
        login_user: root
        login_password: "{{ mysql_root_password }}"
 
    - name: Create MySQL database
      mysql_db:
        name: "{{ mysql_db_name }}"
        state: present
        login_user: root
        login_password: "{{ mysql_root_password }}"
 
    - name: Create MySQL user
      mysql_user:
        name: "{{ mysql_user }}"
        password: "{{ mysql_user_password }}"
        priv: "{{ mysql_db_name }}.*:ALL"
        state: present
        login_user: root
        login_password: "{{ mysql_root_password }}"
 
    - name: Install cron package
      apt:
        name: cron
        state: present
 
    - name: Ensure cron is running
      service:
        name: cron
        state: started
        enabled: yes
 
    - name: Create backup directory
      file:
        path: "{{ backup_dir }}"
        state: directory
        mode: '0755'
 
    - name: Create backup script
      copy:
        content: |
          #!/bin/bash
          mysqldump -u {{ mysql_user }} -p{{ mysql_user_password }} {{ mysql_db_name }} > {{ backup_dir }}/backup_$(date +\%F).sql
        dest: /usr/local/bin/mysql_backup.sh
        mode: '0755'
 
    - name: Set up cron job for database backup
      cron:
        name: "MySQL Backup"
        minute: "{{ cron_time.split()[0] }}"
        hour: "{{ cron_time.split()[1] }}"
        day: "{{ cron_time.split()[2] }}"
        month: "{{ cron_time.split()[3] }}"
        weekday: "{{ cron_time.split()[4] }}"
        job: "/usr/local/bin/mysql_backup.sh"
```
- Content: Automates the installation of PostgreSQL, sets up the database, creates a user, and configures a cron job for backups. It also includes variables for database configuration and backup settings.

![alt text](img/image2.png)

4. **Backup Script**
> Filename: scripts/backup.sh
- Content: A script to perform the backup of the PostgreSQL database. This script should be referenced in the cron job defined in the playbook.
```bash
#!/bin/bash

mkdir /srv/backups/mysql/

mysqldump -u {{ mysql_user }} -p{{ mysql_user_password }} {{ mysql_db_name }} > {{ backup_dir }}/backup_$(date +\%F).sql
```