# Bind9 Module

This module will install and configure a bind9 server 

## Usage

### Minimal server configuration

```puppet
class { 'bind': 
  domain_name         => 'mydomain.local',
  network_address     => '192.168.0.0',
  vpn_network_address => '192.168.1.0',
  network_prefix      => '192.168.0',
  fallback_dns        => '8.8.8.8',
  ns_ip               => '192.168.0.253',
  gateway_ip          => '192.168.0.254',
  network_length      => '24',
  hosts               => { 'toto' => { 'ip' => '.101' } },
}
```
This will do the typical install, configure and service management. 
Lots of this is redundant, need to make this cleaner. 
Host configuration will be separated shortly


## Limitations

* This module has been tested on Debian Wheezy, Squeeze.

## License

All the code is freely distributable under the terms of the LGPLv3 license.

## Contact

Need help ? contact@alkivi.fr

## Support

Please log tickets and issues at our [Github](https://github.com/alkivi-sas/)
