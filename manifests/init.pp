# php/manifests/init.pp - various ways of installing php
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# changed and improved by immerda project group admin(at)immerda.ch
# See LICENSE for the full license granted to you.

#php
class php {
    case $operatingsystem {
        centos: { include php::centos }
        debian: { include php::debian }
        ubuntu: { include php::ubuntu }
        gentoo: { include php::gentoo }
        default: { include php::base }
    }
}

class php::base {
    package{php:
        ensure => present,
        notify => Service[apache],
    }
    file{php_ini_config:
        path => '/etc/php.ini',
        source => [
	        "puppet://$server/files/php/${fqdn}/php.ini",
	        "puppet://$server/files/php/php.ini",
	        "puppet://$server/php/php.ini"
	    ],
	    owner => root,
	    group => 0,
	    mode => 0644,
	    require => [ Package[php], Package[apache] ],
	    notify => Service[apache],
    }

    include php::suhosin
    include php::apc
}

class php::devel {
    package{'php-devel':
        ensure => installed,
        require => Package['php'],
    }
}

class php::centos inherits php::base {
    include yum::remi
    include php::centos::common

    Package[php]{
        require => Yum::Managed_yumrepo['remi'],
    }
}

class php::centos::common {
    package{ 
        [ 'php-common', 'php-idn', 'php-tidy', 
            'php-gd', 'php-mhash' ]:
        ensure => installed,
        require => Package['php'],
    }

    php::pecl{'Fileinfo': }
    php::pear{ [ 'MDB2', 'MDB2-Driver-pgsql', 'MDB2-Driver-mysql', 
                'Cache-Lite', 'Date-Holidays', 'XML-Serializer' ]: 
    }
}

class php::debian inherits php::base {
    #dunno yet about this config file under debian
    File[php_ini_config]{
        path => '/etc/php5/apache2/php.ini',
    }
    Package[php]{
        name => 'php5',
    }

	package { [ "php5", "php5-cli", "libapache2-mod-php5", 
                "phpunit2", "php5-common" ]: 
        ensure => installed, 
        required => Package[php],
    }

	php::pear { [ "auth-pam", "curl", "idn", "imap", "json", "ldap", "mcrypt", "mhash",
		            "ming", "mysql", "odbc", "pgsql", "ps", "pspell", "recode", "snmp",
		            "sqlite", "sqlrelay", "tidy", "uuid", "xapian", "xmlrpc", "xsl" ]:
	    version => 5
	}

	include "php::debian::common"
}
# ubuntu might be the same as debian
class php::ubuntu inherits php::debian {}


class php::debian::common {
	php::pear { [ auth, benchmark, cache, cache-lite, date, db, file, fpdf, gettext,
		    html-template-it, http, http-request, log, mail, mail-mime, net-checkip,
		    net-dime, net-ftp, net-imap, net-ldap, net-sieve, net-smartirc, net-smtp,
		    net-socket, net-url, pager, radius, simpletest, services-weather, soap,
		    sqlite3, xajax, xml-parser, xml-serializer, xml-util ]:
	}
}

class php::gentoo inherits php::base {
    File[php_ini_config]{
        path => "/etc/php/apache2-php5/php.ini",
    }
    Package[php]{
        category => 'dev-lang',
    }
}

define php::pecl(
    $phpversion = '',
    $ensure = 'installed',
    $mode = 'package'
) {
    include php::pear::common
    include php::pecl::common
    case $mode {
        package: {
            php::package{$name:
                phpversion => $phpversion,
                ensure => $ensure,
                mode => 'pecl',
            }
        }
        cli: {
            php::install{$name:
                ensure => $ensure,
                mode => 'pecl',
                require => Package['gcc'],
            }
            file{"/etc/php.d/$name.ini":
                content => "# File manged by puppet!\nextension=geoip.so",
                notify => Service['apache'],
                owner => root, group => 0, mode => 0644;
            }
        }
        default: { fail("no such mode: $mode for php::pecl") }
    }
}

define php::pear (
    $phpversion = '',
    $ensure = 'installed',
    $mode = 'package'
) {
	include php::pear::common
    case $mode {
        package: {
            php::package{$name:
                phpversion => $phpversion,
                ensure => $ensure,
                mode => 'pear',
            }
        }
        cli: {
            php::install{$name:
                ensure => $ensure,
                mode => 'pecl',
            }
        }
        default: { fail("no such mode: $mode for php::pecl") }
    }
}

define php::package(
    $phpversion = '',
    $ensure = 'installed',
    $mode = 'pear'
){
    package{"php${phpversion}-$name":
        ensure => $ensure,
        require => Package['php'],
    }
    case $operatingsystem {
        centos,redhat,fedora: {
            Package["php${phpversion}-$name"]{
                name => "php${phpversion}-$mode-$name",
            }
         }
    }
    if $require {
        Package["php${phpversion}-$name"]{
            require +> $require,
        }
    }
}

define php::install(
    $ensure = 'installed',
    $mode = 'pecl'
){
    include php::pear::common::cli
    case $operatingsystem {
        centos,redhat: {
            include php::devel 
        } 
    }

    case $ensure {
        installed,present: { $ensure_str = 'install' }
        absent: { $ensure_str = 'remove' }
        default: { fail("no such ensure: $ensure for php::install") }
    }

    $cli_part = "$ensure_str $name"

    case $mode {
        'pecl': {
            $cli_str = "pecl $cli_part"
        }
        'pear': {
            $cli_str = "pear $cli_part"
        }
        default: { fail("no such method: $method for php::install") }
    } 

    exec{"php_${mode}_${name}":
        command => $cli_str,
        notify => Service['apache'],
    }
    case $ensure {
        installed,present: {
            Exec["php_${mode}_${name}"]{
                unless => "$mode list | egrep -q \"^$name\W+\""
            }
        }
        absent: {
            Exec["php_${mode}_${name}"]{
                onlyif => "$mode list | egrep -q \"^$name\W+\""
            }
        }
        default: { fail("no such ensure: $ensure for php::install") }
    }
    if $require {
        case $operatingsystem {
            centos,redhat,fedora: {
                Exec["php_${mode}_${name}"]{
                    require =>  [ Package['php'], Package['php-pear'], 
                        Package['php-common'], Package['php-devel'], $require ],
                }
            }
            default: {
                Exec["php_${mode}_${name}"]{
                    require =>  [ Package['php'], Package['php-pear'], 
                        Package['php-common'], $require ],
                }
            }
        }
    } else {
        case $operatingsystem {
            centos,redhat,fedora: {
                Exec["php_${mode}_${name}"]{
                    require =>  [ Package['php'], Package['php-pear'], 
                        Package['php-common'], Package['php-devel'] ],
                }
            }
            default: {
                Exec["php_${mode}_${name}"]{
                    require =>  [ Package['php'], Package['php-pear'], 
                        Package['php-common'] ],
                }
            }
        }
    }
    if $notify {
        Exec["php_${mode}_${name}"]{
            notify => $notify,
        }
    }
}

class php::pear::common {
	package { "php-pear": ensure => installed }
}
class php::pecl::common {
	include gcc
}

class php::pear::common::cli {
    # updates for pear installations
    # we put a Z in front to ensure that it gets executed after the dail yum update
    file{'/etc/cron.daily/Z_pear_upgrade.sh':
        source => "puppet://$server/php/pear/$operatingsystem/pear_upgrade.sh",
        owner => root, group => 0, mode => 0700;
    }
}


