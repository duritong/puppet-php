# manifests/packages/services_weather.pp

class php::packages::services_weather {
    php::pear{'Services_Weather': 
        mode => 'cli', 
    }
}
