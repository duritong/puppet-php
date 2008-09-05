# manifests/packages/geoip.pp

class php::packages::geoip {

    include geoip

    php::pecl{'geoip': 
        mode => 'cli', 
    }
}
