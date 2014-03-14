# === Group management
#
#

define hiera_users::configure::groups ( $data ) {
  if ( ! defined(Group[$name]) ) {
    group { $name :
      ensure     => $data[$name]['ensure'],
      gid        => $data[$name]['gid'],
      provider   => $data[$name]['provider'],
      system     => $data[$name]['system'],
      alias      => $data[$name]['alias'],
      audit      => $data[$name]['audit'],
      before     => $data[$name]['before'],
      loglevel   => $data[$name]['loglevel'],
      noop       => $data[$name]['noop'],
      notify     => $data[$name]['notify'],
      require    => $data[$name]['require'],
      schedule   => $data[$name]['schedule'],
      subscribe  => $data[$name]['subscribe'],
      tag        => $data[$name]['tag'],
    }
  }
}
