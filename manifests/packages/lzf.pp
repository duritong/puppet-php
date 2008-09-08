# manifests/packages/lzf.pp

class php::packages::lzf {
    php::pecl{'LZF': 
        mode => 'cli', 
    }
}
