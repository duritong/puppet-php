class php::snuffleupagus::global (
  Hash[
    Pattern[/\A[0-9]{3}\-\w+/], String[1]
  ] $base_rules = {},
) {
  # based on https://snuffleupagus.readthedocs.io/config.html#miscellaneous-examples
  $rules = {
    '010-mail-add-params' => '# Prevent various `mail`-related vulnerabilities
sp.disable_function.function("mail").param("additional_parameters").value_r("(?!^\\\\-f[a-zA-Z@.-_+]+$)\\\\-").drop();',
    '020-putenv'          => '# Since it\'s now burned, me might as well mitigate it publicly
sp.disable_function.function("putenv").param("setting").value_r("LD_").drop();',
    '030-includes'        => '##Prevent various `include`-related vulnerabilities
sp.disable_function.function("require_once").value_r("\.php$").allow();
# wordpress requires .svg
sp.disable_function.function("require_once").value_r("\.svg$").allow();
# drupal requires .inc
sp.disable_function.function("require_once").value_r("\.inc$").allow();
sp.disable_function.function("include_once").value_r("\.php$").allow();
sp.disable_function.function("require").value_r("\.php$").allow();
sp.disable_function.function("include").value_r("\.php$").allow();
sp.disable_function.function("require").value_r("\.inc$").allow();
sp.disable_function.function("include").value_r("\.inc$").allow();
sp.disable_function.function("require_once").drop();
sp.disable_function.function("include_once").drop();',
    '040-system'          => '# Prevent `system`-related injections
sp.disable_function.function("system").param("command").value_r("[$|;&`\\\\n]").drop();
sp.disable_function.function("shell_exec").param("command").value_r("[$|;&`\\\\n]").drop();
sp.disable_function.function("exec").param("command").value_r("[$|;&`\\\\n]").drop();
sp.disable_function.function("proc_open").param("command").value_r("[$|;&`\\\\n]").drop();',
    '050-runtime-mods' => '# Prevent runtime modification of interesting things
sp.disable_function.function("ini_set").param("varname").value("assert.active").drop();
sp.disable_function.function("ini_set").param("varname").value("zend.assertions").drop();
sp.disable_function.function("ini_set").param("varname").value("memory_limit").drop();
sp.disable_function.function("ini_set").param("varname").value("include_path").drop();
sp.disable_function.function("ini_set").param("varname").value("open_basedir").drop();',
    '060-env-recon'       => '# Detect some backdoors via environnement recon
sp.disable_function.function("ini_get").param("varname").value_r("(?:allow_url_fopen|open_basedir|suhosin)").drop();',
    '070-file-upload'     => '#File upload
sp.disable_function.function("move_uploaded_file").param("destination").value_r("\\\\.ph").drop();
sp.disable_function.function("move_uploaded_file").param("destination").value_r("\\\\.ht").drop();',
  } + $base_rules
}
