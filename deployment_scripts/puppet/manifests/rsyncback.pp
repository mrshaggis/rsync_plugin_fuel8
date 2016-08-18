$rsyncbackup_hash = hiera('rsync-plugin-fuel8',{})


class {'rsyncbackup':
  base => $rsyncbackup_hash['base']
}

class {'::firewall':}

firewall {'837 rsync':
  port   => 837,
  proto  => 'tcp',
  action => 'accept',
}

