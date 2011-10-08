# manifests/extensions/common.pp

class php::extensions::common {
    php::package{
        [ 'common', 'tidy',
            'gd', 'mhash' ]:
        mode => 'direct',
    }
    if $php_centos_use_remi or $php_centos_use_testing {
      info("php-pecl-json is included in php-common of remi")
    } else {
      php::package{'json':
        mode => 'pecl',
      }
    }
    include php::pear::common
}
