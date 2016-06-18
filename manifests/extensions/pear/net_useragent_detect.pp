# the Net_UserAgent_Detect package
class php::extensions::pear::net_useragent_detect {
  if versioncmp($::operatingsystemmajrelease,'5') > 0 {
    package{'php-pear-Net-UserAgent-Detect':
      ensure => installed,
    }
  } else {
    php::pear{'Net_UserAgent_Detect':
      mode => 'cli',
    }
  }
}
