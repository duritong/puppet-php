# manifests/mysql.pp

class php::mysql {
    case $operatingsystem {
        gentoo: { info("gentoo manges php modules with useflags") }
        default: { 
            php::package{'mysql': 
            	mode => direct,
            } 
        }
    }
}
