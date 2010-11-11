class php::extensions::spreadsheet_excel {
    package{ 'php-pear-Spreadsheet-Excel-Writer':               
        ensure => installed,
        required => Package[php],
    }
}
