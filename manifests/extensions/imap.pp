# manage imap extension
class php::extensions::imap {
  php::package{'imap':
    mode => 'direct',
  }
}

