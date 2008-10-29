# manifests/extensions/xml.pp

class php::extensions::xml {
    php::package{'xml':
        mode => 'direct',
    }
}

