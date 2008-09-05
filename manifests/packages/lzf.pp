# manifests/packages/lzf.pp

class php::packages::lzf {
    php::pecl{'lzf': 
        mode => 'cli', 
    }
}
