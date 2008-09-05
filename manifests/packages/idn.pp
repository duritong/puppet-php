# manifests/packages/idn.pp

class php::packages::idn {
    include libidn::devel

    php::pecl{'idn':
        mode => 'cli',
        state => 'beta',
        target_mode => 'pear',
    }
}
