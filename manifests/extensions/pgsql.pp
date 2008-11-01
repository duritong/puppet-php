# manifests/extensions/pgsql.pp

class php::extensions::pgsql {
    php::package{'pgsql':
        mode => 'direct',
    }
}

