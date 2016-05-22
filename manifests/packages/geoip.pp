# manage geoip extension
class php::packages::geoip {
  php::pecl{'geoip': 
    mode => 'cli', 
  }
}
