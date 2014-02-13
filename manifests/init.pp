# configure an array in $scopy containing a list of user lists to load.
# due to how puppet merges arrays, a list of users/groups/keys 

class hiera_users (
  $scope = [
    hiera('hiera_users::scope', [
      'default',
      ]
    )
  ]
) {

  hiera_users::configure { $scope: }
}
