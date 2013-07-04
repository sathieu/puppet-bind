class bind::config_files {

  # named.conf
  if $bind::bool_manage_config_file_main {
    file { 'named.conf':
      ensure  => $bind::manage_file,
      path    => $bind::config_file_main,
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      require => Package[$bind::package],
      notify  => $bind::manage_service_autorestart,
      content => $bind::manage_file_main_content,
      replace => $bind::manage_file_replace,
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
  }
  # named.conf.options
  if $bind::bool_manage_config_file_options {
    file { 'named.conf.options':
      ensure  => $bind::manage_file,
      path    => $bind::config_file_options,
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      require => Package[$bind::package],
      notify  => $bind::manage_service_autorestart,
      content => $bind::manage_file_options_content,
      replace => $bind::manage_file_replace,
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
  }
  # named.conf.local
  if $bind::bool_manage_config_file_local {
    if $bind::bool_bool_absent {
      file { 'named.conf.local':
        ensure  => $bind::manage_file,
        path    => $bind::config_file_local,
        mode    => $bind::config_file_mode,
        owner   => $bind::config_file_owner,
        group   => $bind::config_file_group,
        require => Package[$bind::package],
        notify  => $bind::manage_service_autorestart,
        replace => $bind::manage_file_replace,
        audit   => $bind::manage_audit,
        noop    => $bind::bool_noops,
      }
    } else {
      include concat::setup
      if $bind::manage_file_local_source or $bind::manage_file_local_content {
        concat { $bind::config_file_local:
          mode    => $bind::config_file_mode,
          owner   => $bind::config_file_owner,
          group   => $bind::config_file_group,
          require => Package[$bind::package],
          notify  => $bind::manage_service_autorestart,
          audit   => $bind::manage_audit,
          noop    => $bind::bool_noops,
        }
        concat::fragment { 'bind_head':
          target  => $bind::config_file_local,
          order   => '01',
          mode    => $bind::config_file_mode,
          owner   => $bind::config_file_owner,
          group   => $bind::config_file_group,
          source  => $bind::manage_file_local_source,
          content => $bind::manage_file_local_content,
          audit   => $bind::manage_audit,
          noop    => $bind::bool_noops,
        }
      }
    }
  }
  # named.conf.default-zones
  if $bind::bool_manage_config_file_default_zones {
    file { 'named.conf.default-zones':
      ensure  => $bind::manage_file,
      path    => $bind::config_file_default_zones,
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      require => Package[$bind::package],
      notify  => $bind::manage_service_autorestart,
      content => $bind::manage_file_default_zones_content,
      replace => $bind::manage_file_replace,
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
  }

}
