# manage mysql extension
class php::extensions::mysql {
  if versioncmp($facts['os']['release']['major'],'8') < 0 {
    php::package { 'mysql':
      mode => 'direct',
    }
  } else {
    php::package { 'mysqlnd':
      mode => 'direct',
    }
  }
}
