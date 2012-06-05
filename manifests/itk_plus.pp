class php::itk_plus inherits php::itk {
    case $::operatingsystem {
        centos: { include php::itk_plus::centos }
    }
}
