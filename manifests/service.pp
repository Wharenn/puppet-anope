class anope::service {

  if $::osfamily == 'Debian' {

      file { '/etc/init.d/anope':
        ensure   => file,
        mode     => '0755',
        content  => template('anope/anope.erb'),
      }

      service { 'anope':
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => File['/etc/init.d/anope'],
      }
  }

}


