# manifests/extensions/alldbs.pp

class php::extensions::alldbs {
    include php::extensions::mysql
    include php::extensions::pgsql
}

