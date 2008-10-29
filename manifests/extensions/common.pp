# manifests/extensions/common.pp

class php::extensions::common {
    php::package{
        [ 'cli', 'common', 'tidy',
            'gd', 'mhash' ]:
    }
    php::package{'json':
        mode => 'pecl',
    }
    include php::pear::common
}
