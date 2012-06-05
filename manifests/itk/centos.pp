
class php::itk::centos inherits php::centos {
    File['/etc/httpd/conf.d/php.conf']{
        source => [
            "puppet:///modules/site_php/apache_itk/${::operatingsystem}/${::fqdn}/php.conf",
            "puppet:///modules/site_php/apache_itk/${::operatingsystem}/php.conf",
            "puppet:///modules/php/apache_itk/${::operatingsystem}/php.conf"
        ],
    }
}
