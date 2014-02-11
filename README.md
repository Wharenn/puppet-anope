# Anope puppet module

This is a fork of [Wharenn's anope puppet module](https://github.com/Wharenn/puppet-anope).

Current module version : 1.8

Supported Anope version : 1.8.8

This puppet module allows you to easily install an Anope IRC services on your server.

It will install a Anope IRC Services and let you config it with puppet.

You may be interested by the following modules :

* UnrealIRC Puppet Module for IRC server

  https://github.com/Tehnix/puppet-unrealirc

## How to use

### Quickly setup services

    class { '::anope':
        config_content => template('profile/anope.conf.erb'),
    }

### Custom setup

    class { '::anope':
        install_path =>     '/var/lib/anope',
        services_path =>    '/var/lib/anope/services',
        user =>             'anope',
        group =>            'anope',
        pidfile =>          '/var/lib/anope/services/services.pid',
        url =>              'http://downloads.sourceforge.net/project/anope/anope-stable/Anope%201.8.8/anope-1.8.8.tar.gz',
        config_content =>   undef,
    }

#### Available options :

**install_path**

    Directory where Anope will be installed

**services_path**

    Directory where Anope services will be installed

**user**

    Unix user that should own the Anope directory and run the service

**group**

    Group of the user that should own the Anope directory and run the service

**pidfile**

    Path of the service pid file

**url**

    Url to the anope download archive

**config_content**

    Content of the anope config file. You may use a custom config template of yours as shown in quick setup section.


## Compatibility

This modules currently supports Anope 1.8. It is NOT compatible with Anope 1.9.x yet.

It was tested on debian like systems but should also work on other linux distributions (except for the services part restricted to debian, contributions for other distribs would be welcomed!).

## Issues

For Anope related questions, please have a look to Anope website documentation :

http://anope.org


Please report any module issue to project bug tracker on github

## Licence

This module is distributed under the MIT license. Please check the full license included at the root of the project tree.