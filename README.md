# puppet-module-dnsclient

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with dnsclient](#setup)
   * [What dnsclient affects](#what-dnsclient-affects)
   * [Setup requirements](#setup-requirements)
   * [Beginning with dnsclient](#beginning-with-dnsclient)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Module description

This module manages `/etc/resolv.conf` and its various options. It is
feature complete for the supported platforms.

[Documented with puppet-strings](http://ghoneycutt.github.io/puppet-module-dnsclient/)

## Setup

### What dnsclient affects

Manages the system resolver, `/etc/resolv.conf`.

### Setup requirements
This module requires `stdlib`.

### Beginning with dnsclient

Include the `dnsclient` class and it will configure the resolver to use
Google's public name servers.

## Usage

Minimal and normal usage. See the
[examples](https://github.com/ghoneycutt/puppet-module-dnsclient/tree/master/examples)
directory for more usage examples.

```puppet
include dnsclient
```

## Limitations

This module has been tested to work on the following systems with Puppet
versions 6 and 7 with the Ruby version associated with those releases.
Please see `.travis.yml` for a full matrix of supported versions. This
module aims to support the current and previous major Puppet versions.

 * EL 5
 * EL 6
 * EL 7
 * Debian 6
 * SLES 10
 * SLES 11
 * Solaris 10
 * Ubuntu 10.04 LTS (Lucid Lynx)
 * Ubuntu 12.04 LTS (Precise Pangolin)

## Development

See `CONTRIBUTING.md` for information related to the development of this
module.
