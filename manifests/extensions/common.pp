# manifests/extensions/common.pp

class php::extensions::common {
    php::package{
        [ 'cli', 'common', 'tidy',
            'gd', 'mhash' ]:
        mode => 'direct',
    }
    php::package{'json':
        mode => 'pecl',
    }
    include php::pear::common
}
