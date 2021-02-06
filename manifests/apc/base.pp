# some default stuff for apc
class php::apc::base (
  $dir = '/var/www/apc_tmp',
) {
  Package<| title == 'apache' |> -> file { $dir:
    ensure => directory,
    owner  => root,
    group  => 0,
    mode   => '1777',
  }
  if str2bool($facts['os']['selinux']['enabled']) {
    $seltype = $facts['os']['release']['major'] ? {
      '5'     => 'httpd_sys_script_rw_t',
      default => 'httpd_sys_rw_content_t'
    }
    File[$dir] {
      seltype => $seltype
    }
    selinux::fcontext {
      "${dir}(/.*)?":
        setype => $seltype,
        before => File[$dir];
    } -> Service<| title == 'apache' |>
  }
}
