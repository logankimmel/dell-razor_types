rz_repo { 'centos65':
  ensure  => present,
  iso_url => 'http://mirrors.kernel.org/centos/6.5/isos/x86_64/CentOS-6.5-x86_64-bin-DVD1.iso',
}

rz_repo { 'centos_minimal':
  ensure  => present,
  iso_url => '/opt/iso/CentOS-6.5-minimal.iso',
}

rz_repo { 'centos_deprecated':
  ensure  => present,
  url => '/opt/iso/CentOS-6.5-minimal.iso',
}
