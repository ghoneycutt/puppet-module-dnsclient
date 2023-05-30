# @summary Manage DNS resolver
#
# This module manages `/etc/resolv.conf`.
#
# @param nameservers
#   Array of nameservers. The default use Google's public name servers.
#
# @param nameserver_limit
#   Integer of the number of nameservers to allow in the resolv.conf
#
# @param options
#   Array of options. Set to `[]` if no options line should be present.
#
# @param search
#   Optional array of domains for search list. This is mutually exclusive with `domain`.
#
# @param domain
#   Optional domain setting. This is mutually exclusive with `search`.
#
# @param sortlist
#   Optional array of sortlist entries
#
# @param resolver_config_file
#   Path to resolv.conf
#
# @param resolver_config_file_ensure
#   Value of ensure attribute for the /etc/resolv.conf file resource
#
# @param resolver_config_file_owner
#   User of /etc/resolv.conf
#
# @param resolver_config_file_group
#   Group of /etc/resolv.conf
#
# @param resolver_config_file_mode
#   Mode of /etc/resolv.conf in octal format
#
class dnsclient (
  Array[Stdlib::IP::Address] $nameservers = ['8.8.8.8', '8.8.4.4'],
  Integer[0] $nameserver_limit = 0,
  Array $options = ['rotate', 'timeout:1'],
  Optional[Array[String[1]]] $search = undef,
  Optional[Stdlib::Fqdn] $domain = undef,
  Optional[Array[String[1]]] $sortlist = undef,
  Stdlib::Absolutepath $resolver_config_file = '/etc/resolv.conf',
  String[1] $resolver_config_file_ensure = 'file',
  String[1] $resolver_config_file_owner = 'root',
  String[1] $resolver_config_file_group = 'root',
  Stdlib::Filemode $resolver_config_file_mode = '0644',
) {

  if $search and $domain {
    fail('search and domain are mutually exclusive and both have been defined.')
  }

  # Only 3 nameservers are generally allowed by resolv.conf, so lets ensure that
  # (While letting people do interesting things in hiera to generate nameserver lists)
  # Also provide a way to override
  $nameservers_slice = $nameserver_limit ? {
    0       => $nameservers,
    default => $nameservers[0,$nameserver_limit],
  }

  file { 'dnsclient_resolver_config_file':
    ensure  => $resolver_config_file_ensure,
    content => template('dnsclient/resolv.conf.erb'),
    path    => $resolver_config_file,
    owner   => $resolver_config_file_owner,
    group   => $resolver_config_file_group,
    mode    => $resolver_config_file_mode,
  }
}
