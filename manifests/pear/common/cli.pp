class php::pear::common::cli {
  require php::pecl::common
  require php::pear::common
  require php::devel
  # updates for pear installations
  # we put a Z in front to ensure that it gets executed after the dail yum update
  file{'/etc/cron.daily/Z_pear_upgrade.sh':
    source => "puppet:///modules/php/pear/${::operatingsystem}/pear_upgrade.sh",
    owner => root, group => 0, mode => 0700;
  }
}

