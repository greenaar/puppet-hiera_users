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
    }
  }
}
