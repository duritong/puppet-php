# some default params for php
class php::params(
  $global_settings          = {},
  $timezone                 = 'Europe/Berlin',
  # following https://github.com/sektioneins/pcc
  # and https://www.owasp.org/index.php/PHP_Configuration_Cheat_Sheet
  $security_settings        = {
    'PHP' => {
      expose_php           => 'Off',
      default_charset      => 'UTF-8',
      allow_url_fopen      => 'Off',
      allow_url_include    => 'Off',
      disable_functions    => '"phpinfo, pcntl_exec, show_source"',
    },
    'Assertion' => {
      'assert.active' => 'Off',
    },
    'mail function' => {
      'mail.add_x_header' => 'Off',
    },
  },
  $suhosin_default_settings = {
    'suhosin.cookie.encrypt'                 => 'On',
    'suhosin.get.disallow_ws'                => 'On',
    'suhosin.post.disallow_ws'               => 'On',
    'suhosin.disable.display_errors'         => 'On',
    'suhosin.executor.include.max_traversal' => '5',
    'suhosin.executor.disable_emodifier'     => 'On',
    'session.use_strict_mode'                => 'On',
  },
  $suhosin_cryptkey         = undef,
) {
}
