# Note: config file must be tweaked by the user
class anope(
    $install_path = '/var/lib/anope',
    $services_path = '/var/lib/anope/services',
    $user = 'anope',
    $group = 'anope',
    $pidfile = '/var/lib/anope/services/services.pid',
    $url = 'http://downloads.sourceforge.net/project/anope/anope-stable/Anope%201.8.8/anope-1.8.8.tar.gz',
    $config_content = undef,
) {
  class { '::anope::install': } ->
  class { '::anope::config': } ~>
  class { '::anope::service': }
}