# manage bcmath
class php::extensions::bcmath {
  php::package { 'bcmath':
    mode => 'direct',
  }
}
