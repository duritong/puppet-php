# lzf package
class php::packages::lzf {
  php::pecl { 'lzf':
    mode => 'cli',
  }
}
