# = Class: bind
#
# This is the main bind class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, bind class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $bind_myclass
#
# [*source*]
#   Sets the content of source parameter for local configuration file
#   If defined, bind local config file will have the param: source => $source
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*template*]
#   Sets the path to the template to use as content for local configuration file
#   If defined, bind local config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $bind_options
#
# [*service_autorestart*]
#   Automatically restarts the bind service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $bind_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $bind_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $bind_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $bind_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for bind checks
#   Can be defined also by the (top scope) variables $bind_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $bind_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $bind_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $bind_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $bind_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for bind port(s)
#   Can be defined also by the (top scope) variables $bind_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling bind. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $bind_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $bind_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $bind_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $bind_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in bind::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of bind package
#
# [*service*]
#   The name of bind service
#
# [*service_status*]
#   If the bind service init script supports status argument
#
# [*process*]
#   The name of bind process
#
# [*process_args*]
#   The name of bind arguments. Used by puppi and monitor.
#   Used only in case the bind process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user bind runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file_main*]
#   Main configuration file path (named.conf).
#
# [*manage_config_file_main*]
#   Should the module manage the main config file ?
#   Default: true.
#
# [*config_file_options*]
#   Options configuration file path (named.conf.options).
#
# [*manage_config_file_options*]
#   Should the module manage the options config file ?
#   Default: true.
#
# [*config_file_local*]
#   Local configuration file path, containing views and zones (named.conf.local).
#
# [*manage_config_file_local*]
#   Should the module manage the local config file ?
#   Default: true.
#
# [*config_file_default_zones*]
#   Default zones configuration file path (named.conf.default-zones).
#
# [*manage_config_file_default_zones*]
#   Should the module manage the default zones config file ?
#   Default: false on Debian and derivatives (as Debian already ship it), true otherwise.
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*create_default_view*]
#   Should the class automatically create the default view (zzz_default)
#   Default: true
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $bind_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $bind_protocol
#
#
# See README for usage patterns.
#
class bind (
  $my_class                         = params_lookup( 'my_class' ),
  $source                           = params_lookup( 'source' ),
  $template                         = params_lookup( 'template' ),
  $service_autorestart              = params_lookup( 'service_autorestart' , 'global' ),
  $options                          = params_lookup( 'options' ),
  $version                          = params_lookup( 'version' ),
  $absent                           = params_lookup( 'absent' ),
  $disable                          = params_lookup( 'disable' ),
  $disableboot                      = params_lookup( 'disableboot' ),
  $monitor                          = params_lookup( 'monitor' , 'global' ),
  $monitor_tool                     = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target                   = params_lookup( 'monitor_target' , 'global' ),
  $puppi                            = params_lookup( 'puppi' , 'global' ),
  $puppi_helper                     = params_lookup( 'puppi_helper' , 'global' ),
  $firewall                         = params_lookup( 'firewall' , 'global' ),
  $firewall_tool                    = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src                     = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst                     = params_lookup( 'firewall_dst' , 'global' ),
  $debug                            = params_lookup( 'debug' , 'global' ),
  $audit_only                       = params_lookup( 'audit_only' , 'global' ),
  $noops                            = params_lookup( 'noops' ),
  $package                          = params_lookup( 'package' ),
  $service                          = params_lookup( 'service' ),
  $service_status                   = params_lookup( 'service_status' ),
  $process                          = params_lookup( 'process' ),
  $process_args                     = params_lookup( 'process_args' ),
  $process_user                     = params_lookup( 'process_user' ),
  $config_dir                       = params_lookup( 'config_dir' ),
  $config_file_main                 = params_lookup( 'config_file_main' ),
  $manage_config_file_main          = params_lookup( 'manage_config_file_main' ),
  $config_file_options              = params_lookup( 'config_file_options' ),
  $manage_config_file_options       = params_lookup( 'manage_config_file_options' ),
  $config_file_local                = params_lookup( 'config_file_local' ),
  $manage_config_file_local         = params_lookup( 'manage_config_file_local' ),
  $config_file_default_zones        = params_lookup( 'config_file_default_zones' ),
  $manage_config_file_default_zones = params_lookup( 'manage_config_file_default_zones' ),
  $config_file_mode                 = params_lookup( 'config_file_mode' ),
  $config_file_owner                = params_lookup( 'config_file_owner' ),
  $config_file_group                = params_lookup( 'config_file_group' ),
  $config_file_init                 = params_lookup( 'config_file_init' ),
  $create_default_view              = params_lookup( 'create_default_view' ),
  $pid_file                         = params_lookup( 'pid_file' ),
  $data_dir                         = params_lookup( 'data_dir' ),
  $log_dir                          = params_lookup( 'log_dir' ),
  $log_file                         = params_lookup( 'log_file' ),
  $port                             = params_lookup( 'port' ),
  $protocol                         = params_lookup( 'protocol' )
) inherits bind::params {

  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $bool_noops=any2bool($noops)
  $bool_manage_config_file_main = any2bool($manage_config_file_main)
  $bool_manage_config_file_options = any2bool($manage_config_file_options)
  $bool_manage_config_file_local = any2bool($manage_config_file_local)
  $bool_manage_config_file_default_zones = any2bool($manage_config_file_default_zones)
  $bool_create_default_view = any2bool($create_default_view)

  ### Definition of some variables used in the module
  $manage_package = $bind::bool_absent ? {
    true  => 'absent',
    false => $bind::version,
  }

  $manage_service_enable = $bind::bool_disableboot ? {
    true    => false,
    default => $bind::bool_disable ? {
      true    => false,
      default => $bind::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $bind::bool_disable ? {
    true    => 'stopped',
    default =>  $bind::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $bind::bool_service_autorestart ? {
    true    => Service[bind],
    false   => undef,
  }

  $manage_file = $bind::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $bind::bool_absent == true
  or $bind::bool_disable == true
  or $bind::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $bind::bool_absent == true
  or $bind::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $bind::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $bind::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_main_content = template('bind/named.conf')

  $manage_file_local_source = $bind::source ? {
    ''        => undef,
    default   => $bind::source,
  }

  $manage_file_local_content = $bind::template ? {
    ''        => undef,
    default   => template($bind::template),
  }

  $manage_file_options_content = template('bind/named.conf.options')

  $manage_file_default_zones_content = template('bind/named.conf.default-zones')

  ### Managed resources
  package { $bind::package:
    ensure  => $bind::manage_package,
    noop    => $bind::bool_noops,
  }

  service { 'bind':
    ensure     => $bind::manage_service_ensure,
    name       => $bind::service,
    enable     => $bind::manage_service_enable,
    hasstatus  => $bind::service_status,
    pattern    => $bind::process,
    require    => Package[$bind::package],
    noop       => $bind::bool_noops,
  }

  include bind::config_files
  if $bind::bool_create_default_view and $bind::bool_manage_config_file_local {
    bind::view {
      'zzz_default':
        match_clients        => 'any',
        match_destinations   => 'any',
        match_recursive_only => false;
    }
  }

  ### Include custom class if $my_class is set
  if $bind::my_class {
    include $bind::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $bind::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'bind':
      ensure    => $bind::manage_file,
      variables => $classvars,
      helper    => $bind::puppi_helper,
      noop      => $bind::bool_noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $bind::bool_monitor == true {
    if $bind::port != '' {
      monitor::port { "bind_${bind::protocol}_${bind::port}":
        protocol => $bind::protocol,
        port     => $bind::port,
        target   => $bind::monitor_target,
        tool     => $bind::monitor_tool,
        enable   => $bind::manage_monitor,
        noop     => $bind::bool_noops,
      }
    }
    if $bind::service != '' {
      monitor::process { 'bind_process':
        process  => $bind::process,
        service  => $bind::service,
        pidfile  => $bind::pid_file,
        user     => $bind::process_user,
        argument => $bind::process_args,
        tool     => $bind::monitor_tool,
        enable   => $bind::manage_monitor,
        noop     => $bind::bool_noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $bind::bool_firewall == true and $bind::port != '' {
    firewall { "bind_${bind::protocol}_${bind::port}":
      source      => $bind::firewall_src,
      destination => $bind::firewall_dst,
      protocol    => $bind::protocol,
      port        => $bind::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $bind::firewall_tool,
      enable      => $bind::manage_firewall,
      noop        => $bind::bool_noops,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $bind::bool_debug == true {
    file { 'debug_bind':
      ensure  => $bind::manage_file,
      path    => "${settings::vardir}/debug-bind",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $bind::bool_noops,
    }
  }

}
