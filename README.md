# Puppet module: bind

This is a Puppet module for bind based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-bind

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install bind with default settings

        class { 'bind': }

* Install a specific version of bind package

        class { 'bind':
          version => '1.0.1',
        }

* Disable bind service.

        class { 'bind':
          disable => true
        }

* Remove bind package

        class { 'bind':
          absent => true
        }

* Enable auditing without without making changes on existing bind configuration *files*

        class { 'bind':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'bind':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'bind':
          source => [ "puppet:///modules/example42/bind/bind.conf-${hostname}" , "puppet:///modules/example42/bind/bind.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'bind':
          source_dir       => 'puppet:///modules/example42/bind/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'bind':
          template => 'example42/bind/bind.conf.erb',
        }

* Automatically include a custom subclass

        class { 'bind':
          my_class => 'example42::my_bind',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'bind':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'bind':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'bind':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'bind':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-bind.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-bind]
