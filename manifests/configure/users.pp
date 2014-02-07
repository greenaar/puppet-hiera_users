# === User management, also pushes key if required
#
#

define hiera_users::configure::users ( $data ) {

  if ( ! defined(User[$name]) ) {
    user { $name :
      ensure     => $data[$name]['ensure'],
      comment    => $data[$name]['comment'],
      gid        => $data[$name]['gid'],
      groups     => $data[$name]['groups'],
      home       => $data[$name]['home'],
      managehome => $data[$name]['managehome'],
      password   => $data[$name]['password'],
      provider   => $data[$name]['provider'],
      shell      => $data[$name]['shell'],
      system     => $data[$name]['system'],
      uid        => $data[$name]['uid'],
    }

    if ($data[$name]['ssh_authorized_keys']) and ( $data[$name]['ensure'] == 'present' ) {
      $_sshkey = $data[$name]['ssh_authorized_keys']
      if(is_hash($_sshkey)) {
        $_sshkeys = keys($_sshkey)
        hiera_users::configure::keys {
          $_sshkeys:
            data => $_sshkey,
            user => $name,
            home => $data[$name]['home'],
        }
      } else {
        notify { "ssh_authorized_keys data for ${name} must be in hash form": }
      }
    }
  }
}

