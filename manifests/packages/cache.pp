# the cache package
class php::packages::cache {
  php::pear { 'Cache':
    mode => 'cli',
  }
}
