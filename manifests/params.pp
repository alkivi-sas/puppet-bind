class bind::params () {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $bind_service_config  = '/etc/bind/named.conf'
      $bind_service_default = '/etc/default/bind9'
      $bind_service_name    = 'bind9'
      $bind_package_name    = 'bind9'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

