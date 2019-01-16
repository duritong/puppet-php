# manage a snuffleupagus
define php::snuffleupagus(
  String                        $group,
  Stdlib::Compat::Absolute_Path $etcdir,
  Hash[String,{
    content => String[1],
    order   => String[3,3],
  }]                            $rules = {},
  Array[String]                 $ignore_rules = [],
) {
  include php::snuffleupagus::global
  $target_rules = $php::snuffleupagus::global::rules + $rules
  file{
    "${etcdir}/snuffleupagus.d/${name}.rules":
      content => template('php/snuffleupagus.erb'),
      owner   => root,
      group   => $group,
      mode    => '0640',
  } ~> Service<| title == "fpm-${name}" |>
}
