# Puppet module: bind

This is a Puppet module for bind based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Mathieu Parent, based on Example42 template from Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-bind

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install bind with default settings

        class { 'bind': }

* This module implements most of the usual example42 parameters (version,
  disable, absent, audit_only, noops, ...)

* By default, the configuration in split in several files :
  * named.conf: main configuration file, loading named.conf.options and named.conf.local
  * named.conf.options: the 'options' statement
  * named.conf.local: views and zone

* You can set bind options:

        class {
          'bind':
            options             => {
              'dnssec-validation' => 'auto',
              'auth-nxdomain'     =>  'no',
              'listen-on-v6'      => [ 'any' ],
            };
        }


## USAGE - Views and zones

* By default, a view named zzz_default is created. To disable this feature:

        class {
          'bind':
            create_default_view => false;
        }

* A complete example with some views, zones and record:

        # We create our own views:
        class {
          'bind':
            create_default_view => false,
            forwarders          => [
              '10.2.3.4',
              '10.3.4.5',
            ];
        }

        # A private and a public view (mind sort order!)
        bind::view {
          'private':
            match_clients        => '10.0.0.0/8',
            match_destinations   => 'any',
            match_recursive_only => false,
        }
        bind::view {
          'zz_public':
            match_clients        => 'any',
            match_destinations   => 'any',
            match_recursive_only => false,
        }

        # Use the 'exported resource' template:
        Bind::Zone {
          zonefile_template => 'bind/zonefile.erb',
        }

        bind::zone {
          'priv_example.org':
            zonename => 'example.org',
            view     => 'private',
            masters  => [
              'ns1.example.org',
              'ns2.example.com',
              'ns3.example.com',
            ],
            options  => {
              'allow-transfer' => [ '10.2.3.4', '10.3.4.5' ],
              'allow-query'    => 'any',
            },
          'pub_example.org':
            zonename => 'example.org',
            view     => 'zz_public',
            masters  => [
              'ns1.example.org',
              'ns2.example.com',
              'ns3.example.com',
            ],
            options  => {
              'allow-transfer' => [ '10.2.3.4', '10.3.4.5' ],
              'allow-query'    => 'any',
            },
        }

        Bind::Record {
          zonename => 'example.org',
          view     => 'zz_public',
        }
        @@bind::record {
          'pub_example.org_mx':
            lines    => '@ IN MX 10 smtp1';
          'pub_example.org_somehosts':
            lines    => [
              'ns1   IN A 10.1.2.3',
              'stmp1 IN A 10.9.8.7',
            ]
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'bind':
          source => [ "puppet:///modules/example42/bind/bind.conf-${hostname}" , "puppet:///modules/example42/bind/bind.conf" ], 
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
