# an abstracted way of setting the same options for all
define php::apc::settings(){
  require ::php::apc::base
  augeas{"apc_settings_${name}":
    context => "/files${name}/.anon",
    changes => [
      # http://chrisgilligan.com/wordpress/how-to-configure-apc-cache-on-virtual-servers-with-php-running-under-fcgid/
      'set apc.shm_size 64M',
      'set apc.ttl 0',
      "set apc.mmap_file_mask ${php::apc::base::dir}/apc.XXXXXX",
      # partially because of http://lists.horde.org/archives/horde/Week-of-Mon-20140414/051263.html
      'set apc.enable_cli 1',
    ],
    require => File[$php::apc::base::dir],
  }
}
