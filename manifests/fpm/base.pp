# fpm base stuff
class php::fpm::base(
  String $on_calendar = '*:0/30',
  Hash  $settings     = {
    'pm'                      => 'ondemand',
    'pm.max_children'         => '10',
    'pm.process_idle_timeout' => '30s',
  },
  Boolean $use_munin  = false,
) {
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
      content => template('php/fpm/fpm-kill-pool.timer.erb'),
      enable  => true,
      active  => true,
  }
  if $use_munin {
    include php::fpm::munin
  }
}
