# manifests/packages/cache.pp

class php::packages::cache {
    php::pear{'cache': 
        mode => 'cli', 
    }
}
