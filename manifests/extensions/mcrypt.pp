# manage mcrypt extension
class php::extensions::mcrypt {
  php::package{'mcrypt':
    mode => 'direct',
  }
}

