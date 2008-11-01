# manifests/extensions/smarty.pp

class php::extensions::smarty {
    php::package{'Smarty':
        mode => 'direct',
    }
}

