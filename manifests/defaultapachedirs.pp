# manifests/defaultapachedirs.pp

class php::defaultapachedirs {
    file{'/var/www/upload_tmp_dir':
        ensure => directory,
        require => Package['apache'],
        onwer => root, group => 0, mode => 0755;
    }
    file{'/var/www/session.save_path':
        ensure => directory,
        require => Package['apache'],
        onwer => root, group => 0, mode => 0755;
    }
}
