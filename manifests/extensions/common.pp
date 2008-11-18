# manifests/extensions/common.pp

class php::extensions::common {
    php::package{
        [ 'cli', 'common', 'tidy',
            'gd', 'mhash' ]:
        mode => 'direct',
    }
    case $php_centos_use_remi {
        'true': { info("php-pecl-json is included in php-common of remi") }
        default: {
            php::package{'json':
                mode => 'pecl',
            }
        }
    }
    include php::pear::common
}
