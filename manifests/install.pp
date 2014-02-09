class anope::install {
  
  Exec {
    path => ['/bin', '/usr/bin', '/usr/local/bin', '/sbin', '/usr/sbin'],
  }

  $filename = 'anope'
  $archive = "${filename}.tar.gz"

  # Create irc user and group
  if !defined(Group[$anope::group]) {
    group { $group:
      ensure  => present,
    }
  }

  if !defined(User[$anope::user]) {
    user { $user:
      ensure  => present,
      gid     => $group,
    }
  }

  # Install required mysql lib for anope database use
  if !defined(Package["libmysqlclient15-dev"]) {
    package { 'libmysqlclient15-dev':
      ensure  => present,
    }
  }

  # Retrieve and unpack anope
  exec { 'download-anope':
    command => "wget ${anope::url} -O /tmp/${archive}",
    cwd     => '/tmp',
    creates => "/tmp/${archive}",
  }

  exec { 'extract-anope':
    command => "tar -xvzf /tmp/${archive}",
    cwd     => '/tmp',
    require => Exec['download-anope'],
  }

  # Move extracted directory to install path
  exec { 'anope-dir':
    command => "mv `ls -d /tmp/*/ | grep -i anope | awk '{ print $1 }'` ${anope::install_path}",
    creates => "${anope::install_path}",
    require => Exec['extract-anope'],
  }

  exec { 'make-anope':
    command => "bash configure --with-bindir=${anope::services_path} --with-datadir=${anope::services_path} --with-rungroup=${anope::user} --with-permissions=007 && make && make install",
    timeout => 0,
    cwd     => "${anope::install_path}",
    creates => "${anope::services_path}/anoperc",
    require => Exec['anope-dir'],
  }

  exec { 'chown-anope-dir':
    command => "chown -R ${anope::user}:${anope::group} ${anope::install_path}",
    require => Exec['make-anope'],
  }
}
