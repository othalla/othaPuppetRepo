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

node 'rctn004.int.othalland.xyz' {
  include ::profiles::server
  class { 'apache': }
  class { 'apache::mod::wsgi': }

  $ssl_dir = '/etc/puppet/ssl'
  $puppetboard_certname = 'rctn004.int.othalland.xyz'
  class { 'puppetboard':
    groups              => 'puppet',
    manage_virtualenv   => true,
    puppetdb_host       => 'rctn014.int.othalland.xyz',
    revision            => 'v1.0.0',
    puppetdb_port       => 8081,
    puppetdb_key        => "${ssl_dir}/private_keys/${puppetboard_certname}.pem",
    puppetdb_ssl_verify => "${ssl_dir}/certs/ca.pem",
    puppetdb_cert       => "${ssl_dir}/certs/${puppetboard_certname}.pem",
  }
  class { 'puppetboard::apache::vhost':
    vhost_name => 'puppetboard.int.othalland.xyz',
    port       => 80,
  }
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
