#Permissions on /etc/shadow should allow only root read and write access.
#Command to set permissions (if needed):
    sudo chmod 600 /etc/shadow

#Permissions on /etc/gshadow should allow only root read and write access
#Command to set permissions (if needed):
    sudo chmod 600 /etc/gshadow

#Add user accounts for sam, joe, amy, sara, and admin in a Linux system.
#Command to add each user account:
    sudo adduser sam
    sudo adduser joe
    sudo adduser amy
    sudo adduser sara
    sudo adduser admin

#Add an engineers group to the system.
#Command to add group:
    sudo addgroup engineers

#Add users sam, joe, amy, and sara to the managed group.
#Command to add users to engineers group:
    sudo usermod -a -G engineers sam
    sudo usermod -a -G engineers joe
    sudo usermod -a -G engineers amy
    sudo usermod -a -G engineers sara

#Create a shared folder for this group at /home/engineers.
#Command to create the shared folder:
    sudo mkdir /home/engineers/engineer_folder

#Running an audit on system with Lynis (see below what Lynis is)
    #Lynis is a security auditing tool for Linux, Mac OSX, and UNIX systems. It checks the system and the software configuration, to see if there is any room for improvement the security defenses. All details are stored in a log file. Findings and other discovered data is stored in a report file. This can be used to compare differences between audits. Lynis can run interactively or as a cronjob. Root permissions (e.g. sudo) are not required, however provide more details during the audit.
    #Command to run an audit:
        sudo lynis audit system