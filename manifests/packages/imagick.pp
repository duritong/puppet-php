# imagick package
class php::packages::imagick {
  php::package{'imagick':
    mode => 'pecl',
  }
}
