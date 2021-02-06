# install spreadsheet excel
class php::extensions::spreadsheet_excel {
  package { 'php-pear-Spreadsheet-Excel-Writer':
    ensure  => installed,
    require => Package['php'],
  }
}
