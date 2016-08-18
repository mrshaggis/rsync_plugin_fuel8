$nodes_hash = hiera('nodes')

$rsync_node = filter_nodes($nodes_hash, 'role','rsync-plugin-fuel8')

$rsync_nodename = $::rsync_node[0]['fqdn']

cron {'rsync-backup':
  command => "/usr/bin/rsync -az /etc ${rsync_nodename}::backup/$(hostname)/",
  user    => 'root',
  hour    => 4,
  minute  => 0,
}
