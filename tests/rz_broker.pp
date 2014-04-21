rz_broker { 'puppet':
  ensure        => present,
  broker_type   => 'puppet',
  configuration => {
    'server'  => 'puppet.localdomain'
  }
}

rz_broker { 'noop':
  ensure        => present,
  broker_type   => 'noop',
  configuration => {},
}
