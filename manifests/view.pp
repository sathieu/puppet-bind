# = Define: bind::view
#
# A bind view
#
# == Parameters
#
# [*match_clients*]
#   Array of IP address ranges
#
# [*match_destinations*]
#   Array of IP address ranges
#
# [*match_recursive_only*]
#   Boolean
#
# [*options*]
#   Options applied to all zones of this view (See Bind::Zone for more information).
#
# [*absent*]
#   Set to 'true' to remove view
#
define bind::view(
  $match_clients,
  $match_destinations,
  $match_recursive_only,
  $options              = '',
  $absent               = false
) {

  $bool_match_recursive_only=any2bool($match_recursive_only)
  $bool_absent=any2bool($absent)

  $manage_file = $bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  # Main part
  include bind
  include bind::concat_base

  if $bind::manage_file != 'absent' {
    # before zones
    concat::fragment { "bind_view_${name}":
      ensure  => $manage_file,
      target  => $bind::config_file_local,
      order   => "51-${name}-1",
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      content => template('bind/view.erb'),
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
    # after zones
    concat::fragment { "bind_view_${name}-end":
      ensure  => $manage_file,
      target  => $bind::config_file_local,
      order   => "51-${name}-3",
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      content => "};\n",
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
  }

}
