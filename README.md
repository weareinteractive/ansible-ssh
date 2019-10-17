# Ansible weareinteractive.ssh role

[![Build Status](https://img.shields.io/travis/weareinteractive/ansible-ssh.svg)](https://travis-ci.org/weareinteractive/ansible-ssh)
[![Galaxy](http://img.shields.io/badge/galaxy-weareinteractive.ssh-blue.svg)](https://galaxy.ansible.com/list#/roles/3275)
[![GitHub Tags](https://img.shields.io/github/tag/weareinteractive/ansible-ssh.svg)](https://github.com/weareinteractive/ansible-ssh)
[![GitHub Stars](https://img.shields.io/github/stars/weareinteractive/ansible-ssh.svg)](https://github.com/weareinteractive/ansible-ssh)

> `weareinteractive.ssh` is an [Ansible](http://www.ansible.com) role which:
>
> * installs ssh
> * configures ssh
> * adds logrotate for ssh container logs

**Note:**

> Since Ansible Galaxy switched all role names to the organization name, this role has moved from `franklinkim.ssh` to `weareinteractive.ssh`!

## Installation

Using `ansible-galaxy`:

```shell
$ ansible-galaxy install weareinteractive.ssh
```

Using `requirements.yml`:

```yaml
- src: weareinteractive.ssh
```

Using `git`:

```shell
$ git clone https://github.com/weareinteractive/ansible-ssh.git weareinteractive.ssh
```

## Dependencies

* Ansible >= 2.4
* [sshknownhosts](https://github.com/bfmartin/ansible-sshknownhosts) installed in your `ANSIBLE_LIBRARY` path (see [#4](https://github.com/weareinteractive/ansible-ssh/issues/4))

## Variables

Here is a list of all the default variables for this role, which are also available in `defaults/main.yml`.

```yaml
---
# For more information about default variables see:
# http://www.ansibleworks.com/docs/playbooks_variables.html#id26
#
# ssh_known_hosts:
#  - github.com
# ssh_config:
#   HostKey:
#     - /etc/ssh/ssh_host_rsa_key
#     - /etc/ssh/ssh_host_dsa_key
#     - /etc/ssh/ssh_host_ecdsa_key
#     - /etc/ssh/ssh_host_ed25519_key
#   ChallengeResponseAuthentication: "no"
#   UsePAM: "yes"
#   X11Forwarding: "yes"
#   PrintMotd: "no"
#   AcceptEnv: LANG LC_*
#   Subsystem: sftp /usr/lib/openssh/sftp-server
#

# DEPRICATION NOTICE:
# use the `ssh_config` map @see var/DISTRIBUTION/VERSION.yml
ssh_port: [22]
ssh_protocol: 2
ssh_listen_address: []
ssh_permit_root_login: 'yes'
ssh_pubkey_authentication: 'yes'
ssh_password_authentication: 'yes'

# start on boot
ssh_service_enabled: yes
# current state: started, stopped
ssh_service_state: started
# system wide known hosts
ssh_known_hosts: []

```

## Handlers

These are the handlers that are defined in `handlers/main.yml`.

```yaml
---
# For more information about handlers see:
# http://www.ansibleworks.com/docs/playbooks.html#handlers-running-operations-on-change
#

- name: restart ssh
  action: service name=ssh state=restarted
  when: ssh_service_state != 'stopped'

```


## Usage

This is an example playbook:

```yaml
---

- hosts: all
  become: yes
  roles:
    - weareinteractive.ssh
  vars:
    ssh_known_hosts:
      - github.com
      - bitbucket.org
    ssh_config:
      Port: 22
      Protocol: 2
      HostKey:
        - /etc/ssh/ssh_host_rsa_key
        - /etc/ssh/ssh_host_dsa_key
        - /etc/ssh/ssh_host_ecdsa_key
        - /etc/ssh/ssh_host_ed25519_key
      UsePrivilegeSeparation: "yes"
      KeyRegenerationInterval: 3600
      ServerKeyBits: 1024
      SyslogFacility: AUTH
      LogLevel: INFO
      LoginGraceTime: 120
      PermitRootLogin: "no"
      StrictModes: "yes"
      RSAAuthentication: "yes"
      PubkeyAuthentication: "yes"
      IgnoreRhosts: "yes"
      RhostsRSAAuthentication: "no"
      HostbasedAuthentication: "no"
      PermitEmptyPasswords: "no"
      ChallengeResponseAuthentication: "no"
      PasswordAuthentication: "yes"
      X11Forwarding: "yes"
      X11DisplayOffset: 10
      PrintMotd: "no"
      PrintLastLog: "yes"
      TCPKeepAlive: "yes"
      AcceptEnv: LANG LC_*
      Subsystem: sftp /usr/lib/openssh/sftp-server
      UsePAM: "yes"


```


## Testing

```shell
$ git clone https://github.com/weareinteractive/ansible-ssh.git
$ cd ansible-ssh
$ make test
```

## Contributing
In lieu of a formal style guide, take care to maintain the existing coding style. Add unit tests and examples for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

*Note: To update the `README.md` file please install and run `ansible-role`:*

```shell
$ gem install ansible-role
$ ansible-role docgen
```

## License
Copyright (c) We Are Interactive under the MIT license.
