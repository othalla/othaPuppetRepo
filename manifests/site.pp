node default {
  include profiles::server
}

node 'n001.int.othalland.xyz' {
  include profiles::server
  include profiles::physical
}

node 'r001.int.othalland.xyz' {
  include profiles::server
  include profiles::physical
}

node 'r002.int.othalland.xyz' {
  include profiles::server
  include profiles::physical
}

node 'rctn001.int.othalland.xyz' {
  include ::profiles::server
  include ::profiles::dns
}

node 'rctn003.int.othalland.xyz' {
  include ::profiles::server
  include ::profiles::prometheus_server
}

node 'rctn005.int.othalland.xyz' {
  include ::profiles::server
  class { 'grafana':
    install_method => 'package',
    package_source => 'https://dl.grafana.com/oss/release/grafana_6.1.4_armhf.deb',
  }
}

node 'rctn011.int.othalland.xyz' {
  include ::profiles::server
  include ::profiles::dns
}

node 'rctn012.int.othalland.xyz' {
  include ::profiles::server
  include ::profiles::dhcp
}

node 'rctn013.int.othalland.xyz' {
  include ::profiles::server
  class { 'puppetdb::database::postgresql':
    listen_addresses    => 'postgres.int.othalland.xyz',
    manage_package_repo => false,
  }
}

node 'rctn014.int.othalland.xyz' {
  include ::profiles::server
}

node 'rctn015.int.othalland.xyz' {
  include ::roles::tautulli
}
