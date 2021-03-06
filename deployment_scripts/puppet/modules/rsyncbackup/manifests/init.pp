# == Class: rsyncbackupbackup
#
# Full description of class rsyncbackup here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { rsyncbackup:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class rsyncbackup (
  $package    = $rsyncbackup::params::package,
  $service    = $rsyncbackup::params::service,
  $mountpoint = $rsyncbackup::params::mountpoint,

) inherits rsyncbackup::params {

  package { $package :
    ensure => 'installed',
  }

  service { $service :
    ensure  => 'running',
    enable  => 'true',
    require => Package[$package],
  }

  file { $mountpoint :
    ensure  => 'directory',
    before  => Mount[$mountpoint],
  }

  mount { $mountpoint :
    ensure  => mounted,
    device  => '/var/tmp/',
    fstype  => 'none',
    options => 'rw,bind',
    before  => Service[$service],
  }

  file {'/etc/rsyncd.conf':
    ensure  => present,
    content => template ('rsyncbackup/rsyncd.conf.erb'),
    notify  => Service[$service],
  }

  file {'/etc/default/rsync':
    ensure  => present,
    content => template ('/rsyncbackup/rsyncdefaults.erb'),
    notify  => Service[$service],
  }
}
