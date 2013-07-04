# = Define: bind::record
#
# A bind records
#
# == Parameters
#
# [*zonename*]
#   Zone name. Example: example.org.
#
# [*lines*]
#   Zone line. Example: 'foo.example.org. IN A 10.0.0.1'
#
# [*view*]
#   Zone view.
#   Default: zzz_default (default view, created if $bind::create_default_view is true)
#
define bind::record(
  $zonename,
  $lines,
  $view = 'zzz_default',
) {
  # Magic is done in templates/zonefile.erb
}
