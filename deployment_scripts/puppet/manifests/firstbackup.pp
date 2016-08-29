$nodes_hash = hiera('nodes')

$rsync_node = filter_nodes($nodes_hash, 'role', 'primary-controller', 'base-os')

$rsync_nodename = $rsync_node[0]['fqdn']

cron {'rsync-backup':
  command => "/usr/bin/rsync -az /etc ${rsync_nodename}::backup/$(hostname)/",
  user    => 'root',
}
