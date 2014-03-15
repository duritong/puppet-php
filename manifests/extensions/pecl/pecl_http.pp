class php::extensions::pecl::pecl_http {
  php::pecl{'pecl_http': }
  package{"zlib-devel.${::architecture}":
    ensure => present,
  }
}

