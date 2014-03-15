class php::packages::pecl_http {
  if ($::operatingsystem == 'centos' and $::lsbmajdistrelease == '6') {
    php::package{'http1':
      mode => 'pecl',
    }
  } else {
    php::package{'http':
      mode => 'pecl',
    }
  }
}
