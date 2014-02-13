# === SSH key management
#
#

define hiera_users::configure::keys($user, $data, $home) {

  if ( !defined(Ssh_authorized_keys[$user]) ) {
    if ( ! $home ) {
      $home = "/home/${user}"
    }
    if ! File[$home] {
      file { "${home}":
        ensure  => directory,
        owner   => $user,
        path    => "${home}",
        require => User[$user],
      }
    }
    if ! File["${home}/.ssh"] {
      file { "${home}/.ssh":
        ensure  => directory,
        owner   => $user,
        mode    => '0700',
        path    => "${home}/.ssh",
        require => [File[$home],User[$user]],
      }
    }
    ssh_authorized_key { "${user}-${name}" :
      ensure   => $data[$name]['ensure'],
      key      => $data[$name]['key'],
      options  => $data[$name]['options'],
      provider => $data[$name]['provider'],
      target   => $data[$name]['target'],
      type     => $data[$name]['type'],
      user     => $user,
    }
  }
}
