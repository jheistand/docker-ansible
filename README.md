# docker-ansible
Ubuntu 2204 with Ansible, WinRM, and Kerberos.

Installed ansible-galaxy collections:
- community.windows
- ansible.windows 
- community.general 
- community.vmware 

### Prep:

Update **krb5.conf** in the root of this project with your domain info.  Be mindful of CASE and follow the example file.

Copy your Active Directory Certificate Services certificate chain files to the root of this project.

Copy your ansible project files to the **./ansible** directory.

### Build:

    docker build -t jheistand/docker-ansible .


### Usage:

    docker run --rm -t -v $PWD:/ansible:/ansible -w /ansible \
    -e admin_user='user@DOMAIN.COM' \
    -e admin_pwd='SecretPassword1' \
    jheistand/docker-ansible \
    ansible-playbook -t /ansible/inventory.ini /ansible/playbook.yml -vvv