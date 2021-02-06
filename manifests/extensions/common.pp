# common php extensions
class php::extensions::common {
  php::package {
    ['common', 'tidy', 'gd', 'intl']:
      mode => 'direct';
  }
  include php::pear::common
}
