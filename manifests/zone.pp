# = Define: bind::zone
#
# A bind zone
#
# == Parameters
#
# [*zonename*]
#   Zone name. Example: example.org.
#   Defaults to $name.
#
# [*view*]
#   Zone view.
#   Only usefull on multiview.
#
# [*type*]
#   Sets the zone type (master | slave | hint | stub | static-stub | forward | redirect | delegation-only).
#   Defaults to master.
#
# [*source*]
#   Sets the content of source parameter for zone config.
#   If defined, bind zone config will have the param: source => $source
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*template*]
#   Sets the path to the template to use as content for zone config.
#   If defined, bind zone config will have: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*zonefile_source*]
#   Sets the content of source parameter for zone file (when type=master).
#   If defined, bind zone file will have the param: source => $source
#   Note zonefile_source and zonefile_template parameters are mutually exclusive: don't use both
#
# [*zonefile_template*]
#   Sets the path to the template to use as content for zone file (when type=master).
#   If defined, bind zone file will have: content => content("$template").
#   Recommended value can is 'bind/zonefile.erb'.
#   Note zonefile_source and zonefile_template parameters are mutually exclusive: don't use both
#
# [*absent*]
#   Set to 'true' to remove zone
#
# [*options*]
#   Hash of zone options.
#   Example:
#     options => {
#       'forwarders'  => ['10.1.2.3', '10.1.3.4'],
#       'allow-query' => ['10.1.0.0/16']
#     }
#
# [*ttl*]
#   Default TTL for records (when type=master).
#
# [*masters*]
#   Array of NS servers (when type=master). Example: ['ns1.example.org']
#   You have to ensure that corresponding A records exists.
#
# [*email*], [*refresh*], [*retry*], [*expire*], [*min_ttl*]
#   SOA attributes (when type=master).
#
define bind::zone(
  $zonename          = $name,
  $view              = '',
  $type              = 'master',
  $source            = '',
  $template          = 'bind/zone.erb',
  $zonefile_source   = '',
  $zonefile_template = '', # 'bind/zonefile.erb',
  $absent            = false,
  $options           = '',
  $ttl               = 86400,
  $masters           = '',
  $email             = "root@${zonename}",
  $refresh           = '3h',
  $retry             = '15m',
  $expire            = '1w',
  $min_ttl           = '1h',
) {

  $bool_absent=any2bool($absent)

  if $type == 'master' {
    # Checks
    if $masters == '' {
      fail('$masters attribute not set')
    }
    # Variables
    $real_file = "${bind::config_dir}/zone-${name}"
    $primary_master = $masters[0]
    $dotted_email = regsubst($email, '@', '.', 'G')
    $serial = '@@serial@@'
  } else {
    $real_file = false
  }

  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }
  $manage_file_content = $template ? {
    ''        => undef,
    default   => template($template),
  }

  $zonefile_manage_file_source = $zonefile_source ? {
    ''        => undef,
    default   => $zonefile_source,
  }
  $zonefile_manage_file_content = $zonefile_template ? {
    ''        => undef,
    default   => template($zonefile_template),
  }

  $manage_file = $bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  # Checks
  case $type {
    'master','slave','hint','stub','static-stub','forward','redirect','delegation-only': {}
    default: {fail("Unknown zone type: ${type}")}
  }

  # Main part
  include bind
  include bind::concat_base

  if $bind::manage_file != 'absent' {
    concat::fragment { "bind_zone_${name}":
      ensure  => $manage_file,
      target  => $bind::config_file,
      order   => "51-${view}-2",
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      source  => $manage_file_source,
      content => $manage_file_content,
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
  }
  if $type == 'master' and ($zonefile_manage_file_source or $zonefile_manage_file_content) {
    file { "bind_zonefile-${name}":
      ensure  => $manage_file,
      path    => $real_file,
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      source  => $zonefile_manage_file_source,
      content => $zonefile_manage_file_content,
      require => Package[$bind::package],
      notify  => $bind::manage_service_autorestart,
      replace => $bind::manage_file_replace,
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
  }
}
