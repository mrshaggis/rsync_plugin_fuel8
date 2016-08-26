$nodes_hash = hiera('nodes')

$rsync_node = filter_nodes($nodes_hash, 'role', 'rsync-fuel-plugin8')

$rsync_nodename = $::rsync_node[0]['fqdn']

cron {'rsynb-backup':
  command => "/usr/bin/rsync -az /etc ${rsync_nodename}::backup/$(hostname)/",
  user    => 'root',
}
