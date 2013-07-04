# Class: bind::params
#
# This class defines default parameters used by the main module class bind
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to bind class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class bind::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'bind9',
    default                   => 'bind',
  }

  $service = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'bind9',
    default                   => 'named',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'named',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'bind',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/bind',
  }

  $config_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/bind/named.conf',
    default                   => '/etc/named.conf',
  }

  $config_file_options = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/bind/named.conf.options',
    default                   => '/etc/named.conf',
  }

  $config_file_local = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/bind/named.conf.local',
    default                   => '/etc/named.conf',
  }

  $config_file_default_zones = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/bind/named.conf.default-zones',
    default                   => '/etc/named.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'bind',
    default                   => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/bind9',
    default                   => '/etc/sysconfig/named',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/run/named/named.pid',
    default                   => '/var/run/named.pid',
  }

  $data_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/cache/bind',
    default                   => '/var/bind',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/bind',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/bind/bind.log',
  }

  $port = '53'
  $protocol = '' # tcp and udp

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
