# some default stuff for apc
class php::apc::base(
  $dir = '/var/www/apc_tmp',
){
  Package<| title == 'apache' |> -> file{$dir:
    ensure => directory,
    owner  => root,
    gropup => 0,
    mode   => '1777',
  }
}
