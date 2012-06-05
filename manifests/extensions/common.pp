# manifests/extensions/common.pp

class php::extensions::common {
    php::package{
        [ 'common', 'tidy',
            'gd' ]:
        mode => 'direct',
    }
    if ($::operatingsystem == 'centos' and $::lsbmajdistrelease == '5') {
        php::package{
            'mhash':
              mode => 'direct';
        }
    }
    if $php::params::centos_use_remi or $php::params::centos_use_testin {
      #php-pecl-json is included in php-common of remi or testing
    } else {
      php::package{'json':
        mode => 'pecl',
      }
    }
    include php::pear::common
}
