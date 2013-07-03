class bind::concat_base {
  include concat::setup

  if $bind::manage_file != 'absent' {
    concat { $bind::config_file:
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      require => Package[$bind::package],
      notify  => $bind::manage_service_autorestart,
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
    concat::fragment { 'bind_head':
      target  => $bind::config_file,
      order   => '01',
      mode    => $bind::config_file_mode,
      owner   => $bind::config_file_owner,
      group   => $bind::config_file_group,
      source  => $bind::manage_file_source,
      content => $bind::manage_file_content,
      audit   => $bind::manage_audit,
      noop    => $bind::bool_noops,
    }
  }
}
