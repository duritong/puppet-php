class php::extensions::pecl::pecl_http {
  php::pecl{'pecl_http':
    $package_name = 'http'
  }
  package{"zlib-devel.${::architecture}":
    ensure => present,
  }
}

