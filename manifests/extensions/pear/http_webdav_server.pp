class php::extensions::pear::http_webdav_server {
  php::pear{'HTTP_WebDAV_Server':
    mode => 'cli',
    state => 'beta'
  }
}
