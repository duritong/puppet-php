# manifests/packages/idn.pp

class php::packages::idn {
    php::pecl{'idn-beta':
        mode => 'cli',
    }
}
