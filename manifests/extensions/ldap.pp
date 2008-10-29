# manifests/extensions/ldap.pp

class php::extensions::ldap {
    php::package{'ldap':
        mode => 'direct',
    }
}
