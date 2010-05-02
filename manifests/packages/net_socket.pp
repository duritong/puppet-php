# manifests/packages/net_socket.pp

class php::packages::net_socket {
    php::pear{'Net_Socket': }
}
