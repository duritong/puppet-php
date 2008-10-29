# manifests/extensions/phpunit.pp

class php::extensions::phpunit {
    package{ 'phpunit2':               
        ensure => installed,
        required => Package[php],
    }
}
