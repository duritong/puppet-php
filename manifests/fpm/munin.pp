# munin plugin to monitor fpm processes
class php::fpm::munin {
  munin::plugin::deploy { 'php-fpm-':
    ensure => absent,
    source => 'php/fpm/munin.php',
  } -> munin::plugin {
    ['php-fpm-memory', 'php-fpm-cpu',
    'php-fpm-count', 'php-fpm-time']:
      ensure  => 'php-fpm-',
  }
}
