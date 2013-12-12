class anope::config
{
  # Use custom config or bundled default config file (not recommended)
  if $anope::config_content {
    $content = $anope::config_content
  } else {
    $content = template('anope/services.conf.erb')
  }

  file { "${anope::services_path}/services.conf":
    ensure   => file,
    mode     => '0600',
    owner    => $anope::user,
    group    => $anope::group,
    content  => $content,
    require  => Exec['anope-dir'],
  }
}