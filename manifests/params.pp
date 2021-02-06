# some default params for php
class php::params (
  $global_settings          = {
    'PHP' => {
      upload_max_filesize => '20M',
      post_max_size       => '22M',
    },
  },
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
    'Session' => {
      'session.use_strict_mode' => 'On',
    },
  },
  $suhosin_settings = {},
  $suhosin_default_settings = {
    'suhosin.cookie.encrypt'                 => 'On',
    'suhosin.get.disallow_ws'                => 'On',
    'suhosin.post.disallow_ws'               => 'On',
    'suhosin.disable.display_errors'         => 'On',
    'suhosin.executor.include.max_traversal' => '5',
    'suhosin.executor.disable_emodifier'     => 'On',
    'suhosin.executor.include.whitelist'     => 'phar',
  },
  $suhosin_cryptkey         = undef,
) {
}
