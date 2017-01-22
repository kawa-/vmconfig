#!/bin/bash
set -Ceu

#########################
# My Basic VM config    #
# updated: 2017-01-23   #
#                       #
# ### How to use ###    #
# - become root         #
# - edit 3 params below #
# - $ bash runme.sh     #
#########################

#########################
# edit here in local!!! #
#########################
USERNAME="kawa"
SSH_PORT=50022
SSH_PUBKEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2moP/SIWYiAdZEF5llg3uPF0wdi0CW2eyzUJaP0JJS3wEBlh7ftMQK+o6QO2nx7SjiqG5Z+ltbQybeTo5sYWwG6P6j+DEP92FnMkblVL8i4unjIUpQ14O85JdESu3xLzpp21immYoeiJUrPK4mugxQB+vHQ9K2kd+ZiPiq3BsmUhe4i7tHlkbWKQ2ZzLK+RKqv3RL+nggQN4vd2oer5zoQeoWMVb9kD6QZ+4wUmG/ti+OZvNDJGBPkSLCp3493EIAItBgVVv2cpac6I8aBiQgVx6pEMlQDi5bOM4iF92nhtYe2Cw4+q/XV4y1UDr7NEi5DdfWU1zUGHNxULaG6ksFQ== mk@macbook.local"
#########################
#########################
#########################

# apt
apt-get update
apt-get upgrade -y
apt-get install -y aptitude ssh less vim make gcc g++ openssl libssl-dev build-essential nginx git ufw

# user
useradd -m $USERNAME
mkdir /home/$USERNAME/.ssh
echo $SSH_PUBKEY > /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
chmod 700 -R /home/$USERNAME/.ssh

# ssh
SSHD_CONFIG=`cat <<EOM

### --- these are automatically added ---
Port $SSH_PORT
PermitRootLogin no
PermitEmptyPasswords no
PasswordAuthentication no
ChallengeResponseAuthentication no
X11Forwarding no
AllowUsers $USERNAME
### --- end ---

EOM
`
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
TMP1=`sed "/Port/d" /etc/ssh/sshd_config `
echo "$SSHD_CONFIG$TMP1" >| /etc/ssh/sshd_config

# ufw
ufw allow 80
ufw allow $SSH_PORT
ufw enable

# end
echo "*** DONE ***"
echo "This VM has successfully set."
echo "USERNAME: $USERNAME"
echo "SSH PORT: $SSH_PORT"
echo "Please set password for $USERNAME"
echo 'do: $ service ssh restart'

