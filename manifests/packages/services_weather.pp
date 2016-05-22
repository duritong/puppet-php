# services weather package
class php::packages::services_weather {
    php::pear{'Services_Weather': 
        mode => 'cli', 
    }
}
