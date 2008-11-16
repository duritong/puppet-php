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
	        "puppet://$server/php/config/php.ini"
	    ],
	    require => [ Package[php], Package[apache] ],
	    notify => Service[apache],
	    owner => root, group => 0, mode => 0644;
    }

    include php::suhosin
    include php::apc
    include php::extensions::common
}

class php::centos inherits php::base {
    if $php_centos_use_remi {
        include yum::remi
        Package[php]{
            require => Yum::Managed_yumrepo['remi'],
        }
    }

    file{'/etc/httpd/conf.d/php.conf':
        source => [
            "puppet://$server/files/php/apache/${operatingsystem}/${fqdn}/php.conf",
            "puppet://$server/files/php/apache/${operatingsystem}/php.conf",
            "puppet://$server/php/apache/${operatingsystem}/php.conf"
        ],
	    require => [ Package[php], Package[apache] ],
	    notify => Service[apache],
	    owner => root, group => 0, mode => 0644;
    }
}

# the debian class is not tested!
class php::debian inherits php::base {
    #dunno yet about this config file under debian
    File[php_ini_config]{
        path => '/etc/php5/apache2/php.ini',
    }
    Package[php]{
        name => 'php5',
    }

	package { 'libapache2-mod-php5':
        ensure => installed, 
        required => Package[php],
    }

	php::pear { [ "auth-pam", "curl", "idn", "imap", "ldap", 
		            "ming", "mysql", "odbc", "pgsql", "ps", "pspell", "recode", "snmp",
		            "sqlite", "sqlrelay", "uuid", "xapian", "xmlrpc", "xsl" ]:
	    version => 5
	}

	include "php::debian::common"
}
# ubuntu might be the same as debian
class php::ubuntu inherits php::debian {}


class php::gentoo inherits php::base {
    File[php_ini_config]{
        path => "/etc/php/apache2-php5/php.ini",
    }
    Package[php]{
        category => 'dev-lang',
    }
}
