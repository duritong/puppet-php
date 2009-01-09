# manifests/extensions/alldbs.pp

class php::extensions::alldbs {
    include php::mysql
    include php::extensions::pgsql
}

