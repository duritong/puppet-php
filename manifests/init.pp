# php/manifests/init.pp - various ways of installing php
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# changed and improved by immerda project group admin(at)immerda.ch
# adapated by Puzzle ITC puzzle.ch
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
# See LICENSE for the full license granted to you.

import 'defines.pp'

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
    include php::centos::common

    if $php_centos_use_remi {
        include yum::remi
        Package[php]{
            require => Yum::Managed_yumrepo['remi'],
        }
    }
}

class php::centos::common {
    package{ 
        [ 'php-common', 'php-tidy', 
            'php-gd', 'php-mhash' ]:
        ensure => installed,
        require => Package['php'],
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
