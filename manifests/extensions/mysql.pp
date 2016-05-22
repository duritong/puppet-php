# manage mysql extension
class php::extensions::mysql {
  php::package{'mysql':
    mode => 'direct',
  }
}

