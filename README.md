# Bind9 Module

This module will install and configure a bind9 server 

## Usage

### Minimal server configuration

```puppet
class { 'bind': 
  domain_name     => 'mydomain.local',
  network_address => '192.168.0.0',
  fallback_dns    => '8.8.8.8',
  extra_allow     => [],
}
```

extra_allow definition is used in allow-recursion and allow-query-cache


### Add CNAME alias
```puppet
bind::alias{ 'alkibox':
  type   => 'CNAME',
  dest   => 'ns',
}
```

### Add A alias
```puppet
bind::alias{ 'ns':
  type   => 'A',
  dest   => '192.168.20.2',
}
```

Adding an A alias will automatically create the associated PTR record

## Limitations

* This module has been tested on Debian Wheezy, Squeeze.

## License

All the code is freely distributable under the terms of the LGPLv3 license.

## Contact

Need help ? contact@alkivi.fr

## Support

Please log tickets and issues at our [Github](https://github.com/alkivi-sas/)
