# manage ldap extension
class php::extensions::ldap {
  php::package { 'ldap':
    mode => 'direct',
  }
}
