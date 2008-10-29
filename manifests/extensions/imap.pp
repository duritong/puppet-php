# manifests/extensions/imap.pp

class php::extensions::imap {
    php::package{'imap':
        mode => 'direct',
    }
}

