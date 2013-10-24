#TODO : put host in a separate directory and use concat
class bind (
  $domain_name,
  $network_address,
  $fallback_dns,
  $extra_allow         = [],
  $motd                = true,
  $firewall            = true,
) {

  if($motd)
  {
    motd::register{'Bind9 Server': }
  }

  validate_string($domain_name)
  validate_string($network_address)
  validate_string($fallback_dns)
  validate_array($extra_allow)

  if(!is_ip_address($network_address))
  {
    fail("Parameter network_address is not an ip : ${network_address}")
  }

  # Split network address, remove latest value and join back
  # IPV6 fucker ?
  $network_prefix = join(delete_at(split($network_address, '[.]'), 3), '.')

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

