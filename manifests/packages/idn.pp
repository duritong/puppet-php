# manifests/packages/idn.pp

class php::packages::idn {
    php::pecl{'idn':
        mode => 'cli',
        state => 'beta',
        target_mode => 'pear',
    }
}
