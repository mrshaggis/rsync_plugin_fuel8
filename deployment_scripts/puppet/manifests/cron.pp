cron {'rsync-backup':
  command => "/usr/bin/rsync -az /etc ${mountpoint}",
  user    => 'root',
  hour    => 4,
  minute  => 0,
}
