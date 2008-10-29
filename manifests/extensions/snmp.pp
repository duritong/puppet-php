# manifests/extensions/snmp.pp

class php::extensions::snmp {
    php::package{'snmp':
        mode => 'direct',
    }
}

