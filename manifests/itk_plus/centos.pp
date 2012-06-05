
class php::itk_plus::centos inherits php::itk::centos {
    File['/etc/httpd/conf.d/php.conf']{
        source => [
            "puppet:///modules/site_php/apache_itk_plus/${::operatingsystem}/${::fqdn}/php.conf",
            "puppet:///modules/site_php/apache_itk_plus/${::operatingsystem}/php.conf",
            "puppet:///modules/php/apache_itk_plus/${::operatingsystem}/php.conf"
        ],
    }
}
