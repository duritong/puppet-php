
class php::itk::centos inherits php::centos {
    File['/etc/httpd/conf.d/php.conf']{
        source => [
            "puppet://$server/files/php/apache_itk/${operatingsystem}/${fqdn}/php.conf",
            "puppet://$server/files/php/apache_itk/${operatingsystem}/php.conf",
            "puppet://$server/php/apache_itk/${operatingsystem}/php.conf"
        ],
    }
}
