# make sure we disable mod_php
class php::disable_mod_php {
  # overwrite standard file for mod_php
  # which is obsolete here, but we want
  # to keep the file so an update of the
  # php rpm would not place it there again.
  file{'/etc/httpd/conf.d/php.conf':
    content => "# empty by intend as we are using mod_fcgid\n",
    require => Package['php'],
    notify  => Service['apache'],
  }
}
