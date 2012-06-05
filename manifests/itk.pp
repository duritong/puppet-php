
class php::itk inherits php {
    case $::operatingsystem {
        centos: { include php::itk::centos }
    }
}
