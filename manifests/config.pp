class bind::config () {
  File {
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Class['bind::service'],
  }

  file {  $bind::params::bind_service_config:
    content => template('bind/named.conf.erb'),
  }

  file {  $bind::params::bind_service_default:
    content => template('bind/etc_default.erb'),
  }

  # updat resolv.conf
  # TODO : can we make this out of bind ? not related ?
  file { '/etc/resolv.conf':
    content => template('bind/resolv.conf.erb'),
  }

  # zone
  concat { "/etc/bind/db.${bind::domain_name}":
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class['bind::service'],
  }

  concat::fragment{ "zone_main":
    target  => "/etc/bind/db.${bind::domain_name}",
    content => template('bind/zone.conf.erb'),
    order   => 01,
  }

  # reverse zone
  concat { "/etc/bind/db.${bind::network_prefix}":
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class['bind::service'],
  }

  concat::fragment{ "reverse_zone_main":
    target  => "/etc/bind/db.${bind::network_prefix}",
    content => template('bind/reverse.zone.conf.erb'),
    order   => 01,
  }

  if($bind::firewall)
  {
    file { '/etc/iptables.d/11-bind.rules':
      source  => 'puppet:///modules/bind/bind.rules',
      require => Package['alkivi-iptables'],
      notify  => Service['alkivi-iptables'],
    }
  }
}
