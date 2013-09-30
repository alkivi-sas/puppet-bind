#TODO : put host in a separate directory and use concat
class bind (
  $domain_name,
  $network_address,
  $vpn_network_address,
  $network_prefix,
  $fallback_dns,
  $hosts,
  $ns_ip,
  $gateway_ip,
  $network_length     = 24,
  $vpn_network_length = 24,
  $motd               = true,
) {

  if($motd)
  {
    motd::register{'Bind9 Server': }
  }

  validate_string($domain_name)
  validate_string($network_address)
  validate_string($vpn_network_address)
  validate_string($network_prefix)
  validate_string($fallback_dns)
  validate_hash($hosts)
  validate_string($ns_ip)
  validate_string($gateway_ip)

  $extra_allow = [
    "${network_address}/${network_length}",
    "${vpn_network_address}/${vpn_network_length}"
  ]

  # declare all parameterized classes
  class { 'bind::params': }
  class { 'bind::install': }
  class { 'bind::config': }
  class { 'bind::service': }

  # declare relationships
  Class['bind::params'] ->
  Class['bind::install'] ->
  Class['bind::config'] ->
  Class['bind::service']
}

