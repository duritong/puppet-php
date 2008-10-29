# manifests/pear/common/cli.pp

class php::pear::common::cli {
    # updates for pear installations
    # we put a Z in front to ensure that it gets executed after the dail yum update
    file{'/etc/cron.daily/Z_pear_upgrade.sh':
        source => "puppet://$server/php/pear/$operatingsystem/pear_upgrade.sh",
        owner => root, group => 0, mode => 0700;
    }
}

