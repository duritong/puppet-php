# we still need to explicitly reload it
# since the .service must be loaded by systemd
# when trying to start the .socket and puppet
# won't do these relationships automatically
class php::fpm::systemd_daemon_reload {
  exec { 'systemctl-daemon-reload-fpm':
    command     => 'systemctl daemon-reload',
    refreshonly => true,
  }
}
