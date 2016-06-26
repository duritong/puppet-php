# common php extensions
class php::extensions::common {
  php::package{
    [ 'common', 'tidy', 'gd' ]:
      mode => 'direct';
  }
  if ($::operatingsystem == 'CentOS') and ($::operatingsystemmajrelease == '5') {
    php::package{
      'mhash':
        mode => 'direct';
    }
  } else {
    php::package{
      'intl':
        mode => 'direct';
    }
  }
  include ::php::pear::common
}
