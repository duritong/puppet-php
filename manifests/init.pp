# php/manifests/init.pp - various ways of installing php
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# changed and improved by immerda project group admin(at)immerda.ch
# adapated by Puzzle ITC puzzle.ch
# Marcel Haerry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
# See LICENSE for the full license granted to you.
class php(
  $settings                 = {},
  $timezone                 = $php::params::timezone,
  $security_settings        = $php::params::security_settings,
  $suhosin_settings         = $php::params::suhosin_settings,
  $suhosin_default_settings = $php::params::suhosin_default_settings,
  $suhosin_cryptkey         = $php::params::suhosin_cryptkey,
) inherits php::params {
  include ::php::base
}
