# extensions for all common databases
class php::extensions::alldbs {
  include php::extensions::mysql
  include php::extensions::pgsql
}
