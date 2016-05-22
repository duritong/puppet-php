# pecl http package
class php::packages::pecl_http {
  php::package{'http':
    mode => 'pecl',
  }
}
