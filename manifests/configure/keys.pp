# === SSH key management
#
#

define hiera_users::configure::keys($user, $data, $home) {

  if(!defined(Ssh_authorized_keys[$user])) {
    if ( ! $home ) {
      $home = "/home/${user}"
    }

    file { $home:
      ensure  => directory,
      owner   => $user,
      require => User[$user]
    } ->

    file { "${home}/.ssh":
      ensure  => directory,
      owner   => $user,
      mode    => '0700',
      require => [File[$home],User[$user]]
    } ->

    ssh_authorized_key { "${user}-${name}" :
      ensure   => $data[$name]['ensure'],
      key      => $data[$name]['key'],
      options  => $data[$name]['options'],
      provider => $data[$name]['provider'],
      target   => $data[$name]['target'],
      type     => $data[$name]['type'],
      user     => $user,
      require  => File["${home}/.ssh"],
    }
  }
}
