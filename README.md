puppet-hiera_users
==================

Manage users, groups and ssh keys through hiera.

# Usage

in a manifest:
```
  include hiera_users::configure
```
or
```
  class { 'hiera_users::configure': }
```
in a hiera yaml: ( if loading through hiera_include('classes') )

---
```
classes:
  - hiera_users::configure
```

## Configuration

This module exposes several configurable options.  While you can pass
these options through a manifest, this module works best when pulling
data out of hiera.

```
From hiera:

----------------------------

 Please note, when using layered yaml files, you will want to make
  sure that you have the deep_merge gem installed and configured.
```
gem install deep_merge
```
## in hiera.yaml
```
:merge_behavior:
  - deeper
```
----------------------------
```
hiera_users::configure::_users:
  user1:
    ensure: present
    home: /path/to/home
    shell: /path/to/shell
    uid: 5000
    gid: 4000 # please note, gid must exist
    groups:
      - sudo
      - adm
    password: 'SuperSecretpasswordhash'
    ssh_authorized_keys:
      key-1-user:
        ensure: present
        key: PUBLIC KEY HERE
        options: ssh options, if any
        user: joe
        type: ssh-rsa
  user2:
    ensure: absent
  user3:
    ensure: present
    home: /path/to/home
    shell: /path/to/shell
    gid: 33
    groups:
      - puppet

hiera_users::configure::_groups:
  users:
    ensure: present
    gid: 100
  admins:
    ensure: absent
    gid: 999
  developers:
    ensure: present
    gid: 4000
```

Please note, you can not remove a group that is a user's primary group
without re-assigning a new GID for that user.

Also, if you do not specify a group, a group based on the user's name
is automatically created.

