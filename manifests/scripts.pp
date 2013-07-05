# = Class: bind::scripts
#
# Bind helpers
#
class bind::scripts {
  file {
    '/usr/local/bin/bind-set-serial':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///modules/bind/bind-set-serial.sh';
  }
}
