# manifests/extensions/bcmath.pp

class php::extensions::bcmath {
    php::package{'bcmath':
        mode => 'direct',
    }
}

