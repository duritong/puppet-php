# manifests/extensions/mysql.pp

class php::extensions::mysql {
    php::package{'mysql':
        mode => 'direct',
    }
}

