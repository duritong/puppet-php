# manifests/extensions/idn.pp

class php::extensions::idn {
    php::package{'idn':
        mode => 'direct',
    }
}

