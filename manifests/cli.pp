class php::cli {
  php::package{'cli':
    mode => direct,
    ensure => present,
  }
}