# manifests/extensions/xmlrpc.pp

class php::extensions::xmlrpc {
    php::package{'xmlrpc':
        mode => 'direct',
    }
}

