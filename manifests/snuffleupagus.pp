# manage a snuffleupagus
define php::snuffleupagus (
  String                        $group,
  Stdlib::Compat::Absolute_Path $etcdir,
  Pattern[/^\d+$/]              $version,
  Hash[
    Pattern[/\A[0-9]{3}\-\w+/], String[1]
  ]                             $rules = {},
  Array[String]                 $ignore_rules = [],
) {
  include php::snuffleupagus::global

  if $version =~ /^7/ {
    $target_rules = $php::snuffleupagus::global::rules_v7 + $rules
  } else {
    $target_rules = $php::snuffleupagus::global::rules_v8 + $rules
  }

  file {
    "${etcdir}/snuffleupagus.d/${name}.rules":
      content => template('php/snuffleupagus.erb'),
      owner   => root,
      group   => $group,
      mode    => '0640',
  } ~> Service<| title == "fpm-${name}" |>
}
