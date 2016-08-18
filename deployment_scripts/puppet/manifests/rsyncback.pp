class {'rsyncbackup':}

class {'::firewall':}

firewall {'837 rsync':
  port   => 837,
  proto  => 'tcp',
  action => 'accept',
}

