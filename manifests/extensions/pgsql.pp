# manage pgsql extension
class php::extensions::pgsql {
  php::package{'pgsql':
    mode => 'direct',
  }
}

