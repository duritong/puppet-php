# manifests/suhosin.pp
class php::suhosin {
  case $::operatingsystem {
    centos: {
      if $php::centos_use_remi or $php::centos_use_testing {
        include php::suhosin::package
      }
    }
    debian: {
      if $::lsbdistcodename == 'squeeze' or $::lsbdistcodename == 'sid' {
        include php::suhosin::package
      }
    }
    default: {
      include php::suhosin::package
    }
  }
}
