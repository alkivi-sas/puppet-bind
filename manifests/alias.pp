define bind::alias(
  $dest,
  $source = $title,
  $type   = 'CNAME',
  $order  = 02,
) {

  validate_string($source)
  validate_string($dest)
  validate_re($type, [ '^CNAME$', '^A$' ])

  concat::fragment{ "zone_${title}":
    target  => "/etc/bind/db.${bind::domain_name}",
    content => "${source} IN ${type} ${dest}\n",
    order   => $order,
  }

  if($type == 'A')
  {
    # Add PTR record
    if(!is_ip_address($dest))
    {
      fail("Dest ${dest} is not an ip address")
    }

    # Bracket are use to take real point, not meta carahcter
    $last_digit = split($dest, '[.]')[3]

    concat::fragment{ "reverse_zone_${title}":
      target  => "/etc/bind/db.${bind::network_prefix}",
      content => "${last_digit} IN PTR ${source}.${bind::domain_name}.\n",
      order   => $order,
    }
  }
}
