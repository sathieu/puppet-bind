# = Define: bind::host
#
# Bind records representing a host, optionally with cnames
#
# == Parameters
#
# [*hostname*]
#   Optional hostname.
#   Default: $name
#
# [*ips*]
#   Array of ips (required).
#
# [*cnames*]
#   Optional array of cnames pointing to this host
#
# [*zonename*]
#   Zone name (required). Example: example.org.
#
# [*view*]
#   Optional zone view.
#   Default: zzz_default (default view, created if $bind::create_default_view is true)
#
define bind::host(
  $ips,
  $zonename,
  $hostname = $name,
  $cnames = '',
  $view = 'zzz_default',
) {
  bind::record {
    $name:
      view     => $view,
      zonename => $zonename,
      lines    => template('bind/host.erb');
  }
}
