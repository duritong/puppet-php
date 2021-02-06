# common php extensions
class php::extensions::common {
  php::package {
    ['common', 'tidy', 'gd']:
      mode => 'direct';
  }
  if ($facts['os']['name'] == 'CentOS') and ($facts['os']['release']['major'] == '5') {
    php::package {
      'mhash':
        mode => 'direct';
    }
  } else {
    php::package {
      'intl':
        mode => 'direct';
    }
  }
  include php::pear::common
}
