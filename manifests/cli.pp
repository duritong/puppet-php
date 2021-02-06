# manage cli package
class php::cli {
  php::package { 'cli':
    ensure => present,
    mode   => 'direct',
  }
}
