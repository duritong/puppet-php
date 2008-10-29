# manifests/packages/cache.pp

class php::packages::cache {
    php::pear{'Cache': 
        mode => 'cli', 
    }
}
