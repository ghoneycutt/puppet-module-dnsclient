# dnsclient module #

[![Build Status](https://travis-ci.org/ghoneycutt/puppet-module-dnsclient.png?branch=master)](https://travis-ci.org/ghoneycutt/puppet-module-dnsclient)

This module manages /etc/resolv.conf and its various options.

It makes use of Hiera (http://github.com/puppetlabs/hiera) and demonstrates a
new design pattern in module development that allows for totally data driven
code with no modifications to the module itself as a guiding principle.

# Compatibility #

This module has been tested to work on the following systems with Puppet v3
(with and without the future parser) and Puppet v4 with Ruby versions 1.8.7,
1.9.3, 2.0.0, 2.1.0 and 2.3.1.

 * EL 5
 * EL 6
 * EL 7
 * Debian 6
 * SLES 10
 * SLES 11
 * Solaris 10
 * Ubuntu 10.04 LTS (Lucid Lynx)
 * Ubuntu 12.04 LTS (Precise Pangolin)

# Parameters #

See RESOLV.CONF(5) for more information regarding /etc/resolv.conf settings


nameservers
-----------
Array of name servers.

- *Default*: Google's public name servers

options
-------
Array of options.

- *Default*: 'rotate' and 'timeout:1'

search
------
Array of domains for search list. This is mutually exclusive with **domain**. If both are set, search will be used and domain will be ignored.

- *Default*: none

domain
------
Domain setting. See **search**.

- *Default*: none

sortlist
--------
Array of sortlist addresses.

- *Default*: none

resolver_config_file
--------------------
Path to resolv.conf.

- *Default*: '/etc/resolv.conf'

resolver_config_file_ensure
---------------------------
ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.

- *Default*: file

resolver_config_file_owner
--------------------------
resolv.conf's owner.

- *Default*: 'root'


resolver_config_file_group
--------------------------
resolv.conf's group.

- *Default*: 'root'


resolver_config_file_mode
-------------------------
resolv.conf's mode.

- *Default*: '0644'

conf_replace
-------------------------
Allow or disallow manual edition of resolv.conf. Valid values are true or false.

- *Default*: true
