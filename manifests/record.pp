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
#   Only usefull on multiview.
#
define bind::record(
  $zonename,
  $lines,
  $view = '',
) {
  # Magic is done in templates/zonefile.erb
}
