class bind::service () {
  service { $bind::params::bind_service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}

