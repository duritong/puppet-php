# manifests/packages/ssh2.pp

class php::packages::ssh2 {
    php::pecl{'ssh2': }
}
