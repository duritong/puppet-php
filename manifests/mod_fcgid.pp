# things we need for mod_fcgid & php
class php::mod_fcgid inherits php {
  require php::cli
  include php::disable_mod_php
}
