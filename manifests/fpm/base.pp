# fpm base stuff
class php::fpm::base {
  file{
    '/usr/local/sbin/fpm-kill-pool.sh':
      source => 'puppet:///modules/php/fpm/kill-pool.sh',
      owner  => root,
      group  => 0,
      mode   => '0755',
  } -> systemd::unit_file{
    'fpm-kill-pool.service':
      source => 'puppet:///modules/php/fpm/kill-pool.service',
  } -> systemd::unit_file{
    'fpm-kill-pool.timer':
      content => content('php/fpm/fpm-kill-pool.timer.erb'),
  } ~> service{
    'fpm-kill-pool.timer':
      ensure => running,
      enable => true,
  }
}
