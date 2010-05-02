# manifests/packages/net_sieve.pp

class php::packages::net_sieve {
    require php::packages::net_socket
    php::pear{'Net_Sieve':
      mode => 'cli',
    }
}
