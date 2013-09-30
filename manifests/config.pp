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
  file { '/etc/resolv.conf':
    content => template('bind/resolv.conf.erb'),
  }

  # zone
  file { "/etc/bind/db.${bind::domain_name}":
    content => template('bind/zone.conf.erb'),
  }

  # reverse zone
  file { "/etc/bind/db.${bind::network_prefix}":
    content => template('bind/reverse.zone.conf.erb'),
  }

  file { '/etc/iptables.d/11-bind.rules':
    source  => 'puppet:///modules/bind/bind.rules',
    require => Class['alkivi_base'],
    notify  => Service['alkivi-iptables'],
  }
}
