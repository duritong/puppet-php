
class php::itk::centos inherits php::centos {
    File['/etc/httpd/conf.d/php.conf']{
        source => [
            "puppet://$server/modules/site-php/apache_itk/${operatingsystem}/${fqdn}/php.conf",
            "puppet://$server/modules/site-php/apache_itk/${operatingsystem}/php.conf",
            "puppet://$server/modules/php/apache_itk/${operatingsystem}/php.conf"
        ],
    }
}
