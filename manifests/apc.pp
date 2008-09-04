# manifests/apc.pp

class php::apc {
    package{'php-pecl-apc':
        ensure => installed,
    }
}
