class bind::install () {
  package { $bind::params::bind_package_name:
    ensure => installed,
  }
}
