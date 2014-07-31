define bind::zone(
  $file,
  $type  = 'master',
  $order = 02,
) {

  validate_string($file)

  concat::fragment{ "zone_declaration_${title}":
    target  => $bind::params::bind_service_config,
    content => template('bind/extra_named.conf.erb'),
    order   => $order,
  }
}

