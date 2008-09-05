# manifests/packages/init.pp
# 
# file for all kind of extra php packages

class php::packages::geoip {
    include geoip
    php::pecl{'geoip': 
        mode => 'cli', 
        require => Package['GeoIP'],
    }
}
