# manage a snuffleupagus
define php::snuffleupagus(
  Stdlib::Compat::Absolute_Path        $etcdir,
  Optional[Enum[String,Array[String]]] $source = undef,
) {
  file{
    "${etcdir}/snuffleupagus.d/${name}.rules":
      ensure  => file,
      owner   => root,
      group   => 0,
      mode    => '0644',
      require => File["${etcdir}/snuffleupagus.d"],
      notify  => Service["fpm-${name}"],
  }
  if $source {
    File["${etcdir}/snuffleupagus.d/${name}.rules"]{
      source => $source,
    }
  }
}
