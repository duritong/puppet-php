# common php extensions
class php::extensions::common {
  php::package {
    ['common', 'gd', 'intl']:
      mode => 'direct';
  }
  if versioncmp($facts['os']['release']['major'],'8') < 0 {
    php::package { 'tidy':
      mode => 'direct';
    }
  }
  include php::pear::common
}
