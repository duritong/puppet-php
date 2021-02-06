# manage the devel package
# we want it especially tight to the current
# architecture
class php::devel {
  package { "php-devel.${facts['os']['architecture']}":
    ensure  => installed,
    require => Package['php'],
  }
}
