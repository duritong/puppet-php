# manifests/pear/common.pp

class php::pear::common {
    package { "php-pear": ensure => installed }
}

