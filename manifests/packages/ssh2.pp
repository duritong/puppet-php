# manifests/packages/ssh2.pp

class php::packages::ssh2 {
    include sshd::libssh2::devel

    php::pecl{'ssh2-beta':
        mode => 'cli',
    }
}
