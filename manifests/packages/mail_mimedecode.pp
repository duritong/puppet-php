# mail mimedecode package
class php::packages::mail_mimedecode {
  php::pear { 'Mail_mimeDecode':
    mode => 'cli',
  }
}
