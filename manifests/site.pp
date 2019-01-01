node default {
  include profiles::server
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
  include ::roles::tautulli
}

node 'rctn003.int.othalland.xyz' {
  include profiles::prometheus_server
}

node 'rctn004.int.othalland.xyz' {
  include profiles::reverse_proxy
}

node 'rctn005.int.othalland.xyz' {
  class { 'grafana':
    install_method => 'package',
    package_source => 'https://dl.grafana.com/oss/release/grafana_5.4.2_armhf.deb',
  }
}
