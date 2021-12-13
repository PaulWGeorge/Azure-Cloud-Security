#Step 1: Create, Extract, Compress, and Manage tar Backup Archives

#Command to extract the TarDocs.tar archive to the current directory:
    tar xvvf TarDocs.tar

#Command to create the Javaless_Doc.tar archive from the TarDocs/ directory, while excluding the TarDocs/Documents/Java directory:
    tar cvvf Javaless_Docs.tar --exclude='/home/sysadmin/Projects/TarDocs/Documents/Java' /home/sysadmin/Projects/TarDocs

##Command to ensure Java/ is not in the new Javaless_Docs.tar archive:
    tar tvvf Javaless_Docs.tar | grep Java

#Command to create an incremental archive called logs_backup.tar.gz with only changed files to snapshot.file for the /var/log directory:
    sudo tar cvvzWf logs_backup.tar.gz --listed-incremental=logs_backup.snar --level=0 /var/log


#Step 2: Create, Manage, and Automate Cron Jobs
    
#Cron job for backing up the /var/log/auth.log file:
    0 6 * * 3 tar czf /auth_backup.tgz /var/log/auth.log


#Step 3: Write Basic Bash Scripts

#Brace expansion command to create four subdirectories:
    mkdir -p ~/backups/{freemem,diskuse,openlist,freedisk}
        #I used the -p option since I received an error stating there was no ‘backup’ directory. This option allows for parents to be made when needed.

#Commands to test the script and confirm its execution:
    sudo ./system.sh
    cd ~/backups/freedisk/free_disk.txt
    cat free_disk.txt

#Command to copy system to system-wide cron directory:
    sudo cp ~/system.sh /etc/cron.weekly


#Step 4. Manage Log File Sizes
#Run sudo nano /etc/logrotate.conf to edit the logrotate configuration file.

 #Configuring a log rotation scheme that backs up authentication messages to the /var/log/auth.log.

#Config file edits below:
    /var/log/auth.log {
    weekly
    rotate 7
    notifempty
    delaycompress
    missingok
    endscript
    }

#Check for Policy and File Violations
#Command to verify auditd is active:
    systemctl status auditd


#Set number of retained logs and maximum log file size:
    num_logs = 7
    max_log_file = 35

#Command using auditd to set rules for /etc/shadow, /etc/passwd and /var/log/auth.log:
    -w /etc/shadow -p wra -k hashpass_audit
    -w /etc/passwd -p wra -k userpass_audit
    -w /var/log/auth.log -p wra -k authlog_audit

#Command to restart auditd:
    sudo systemctl restart auditd

#Command to list all auditd rules:
    sudo auditctl -l

#Command to produce an audit report:
    sudo aureport -au

#Create a user with sudo useradd attacker and produce an audit report that lists account modifications:
    sudo useradd attacker
    sudo usermod -aG sudo attacker
    sudo aureport -m

#Command to use auditd to watch /var/log/cron:
    sudo audictl -w /var/log/cron (they will have all permissions added automatically)

#Command to verify auditd rules:
    sudo auditctl -l (output is below with new rule added and auditd restarted)
    -w /etc/shadow -p rwa -k hashpass_audit
    -w /etc/passwd -p rwa -k userpass_audit
    -w /var/log/auth.log -p rwa -k authlog_audit
    -w /var/log/cron -p rwxa

#Perform Various Log Filtering Techniques
#Command to return journalctl messages with priorities from emergency to error:
    journalctl -p 3 -b

#Command to check the disk usage of the system journal unit since the most recent boot:
    sudo journalctl -b -u systemd-journald | less

#Command to remove all archived journal files except the most recent two:
    sudo journalctl --vacuum-file=2

#Command to filter all log messages with priority levels between zero and two, and save output to /home/sysadmin/Priority_High.txt:
    journalctl -p 2 >> /home/sysadmin/Priority_High.txt

#Command to automate the last command in a daily cronjob:
    @daily journalctl -p 2 >> /home/sysadmin/Priority_High.txt