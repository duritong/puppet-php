# net socket package
class php::packages::net_socket {
  php::pear { 'Net_Socket':
    mode => 'cli',
  }
}
