class rsyncbackup::params {
  case $::osfamily {
    'Debian' : {
      $package    = 'rsync'
      $service    = 'rsync'
      $mountpoint = '/var/tmp'
      }
  default: {
    fail("Module ${modulename} is not supported on ${::osfamily}")
  }
  }
}
