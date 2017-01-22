# vmconfig

My Personal shellscript for new virtual machines.

## Preconditions

- VM's OS: Ubuntu or Debian
- Do in root
- wget command (install if necessary)

## What will be done

- update apt
- install aptitude, less, vim, make, gcc, g++, openssl, libssl-dev, build-essential, nginx, git, ufw (allow 80 and 50022)
- create user and set authorized_keys
- set ssh safety (Port 22 -> 50022, PermitRootLogin no, PermitEmptyPasswords no, PasswordAuthentication no, ChallengeResponseAuthentication no, X11Forwarding no, AllowUsers)

## Background

- I always do same things in new VM
- I'm afraid of spelling wrong (especially "authorized_keys") and wrong access permissions
- Ansible, Puppet, Chef and so on. I've heard of them :)
- Idempotence... what is that?

## How to

1. create VM (**Ubuntu or Debian only!**)
2. log in to the VM
3. do the following!

~~~
# use wget or w3m (terminal browser)
$ wget https://gist.githubusercontent.com/kawa-/e83d36bd50b1673ec7fa6ab6071c23c1/raw/8a6bf3e956e65b5e5fac2420e523fc596e2a30b7/runme.sh

# edit 3 params: username, ssh port, your public key
$ vi runme.sh

# run!
$ bash runme.sh

# restart ssh (Caution: The ssh port will be changed!)
$ /etc/init.d/ssh restart
~~~ 

Sometimes you need to install wget command by apt.

~~~
$ apt-get update; apt-get upgrade -y;
$ apt-get install wget
~~~

Or you can use w3m instead of wget.

~~~
$ w3m https://gist.github.com/kawa-/
# ...And search the script, and open as raw. Press shift+s to save. Name it runme.sh.
~~~

## Misc

I don't take any responsibilities if you use this.
If you are happy, let me know your favorite and secure VM settings in GitHub issues.
