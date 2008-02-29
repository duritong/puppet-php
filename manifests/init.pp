# php/manifests/init.pp - various ways of installing php
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

class php {
    case $operatingsystem {
        debian: { include php::debian }
        centos: { include php::centos }
        ubuntu: { include php::ubuntu }
        gentoo: { include php::gentoo }
    }
}

class php::centos {}
class php::ubuntu {}

define php::debian::pear ($version = '') {
	include "php::debian::pear::common"

	package { "php${version}-${name}": ensure => installed }
}

class php::debian::pear::common {
	package { ["php-pear", "php5-common" ]: ensure => installed }
}

class php::debian {

	package { [ "php5", "php5-cli", "libapache2-mod-php5", "phpunit2" ]: ensure => installed }

	php::debian::pear { [
		"auth-pam", "curl", "idn", "imap", "json", "ldap", "mcrypt", "mhash",
		"ming", "mysql", "odbc", "pgsql", "ps", "pspell", "recode", "snmp",
		"sqlite", "sqlrelay", "tidy", "uuid", "xapian", "xmlrpc", "xsl"
		]:
			version => 5
	}

	include "php::debian::common"
}



class php::debian::common {
	php::pear {
		[ auth, benchmark, cache, cache-lite, date, db, file, fpdf, gettext,
		html-template-it, http, http-request, log, mail, mail-mime, net-checkip,
		net-dime, net-ftp, net-imap, net-ldap, net-sieve, net-smartirc, net-smtp,
		net-socket, net-url, pager, radius, simpletest, services-weather, soap,
		sqlite3, xajax, xml-parser, xml-serializer, xml-util ]:
	}
}

class php::gentoo {
   package { 'php':
        ensure => present,
        category => $operatingsystem ? {
            gentoo => 'dev-lang',
            default => '',
        }
    }
   
    # config files
    file{
        "/etc/php/apache2-php5/php.ini":
	        source => [
	            "puppet://$server/dist/php/apache2_php5_php.ini/${fqdn}/php.ini",
	            "puppet://$server/php/apache2_php5_php.ini/${fqdn}/php.ini",
	            "puppet://$server/php/apache2_php5_php.ini/default/php.ini"
	        ],
	        owner => root,
	        group => 0,
	        mode => 0644,
	        require => Package[php],
	        require => Package[apache],
	        notify => Service[apache],
    }
}



