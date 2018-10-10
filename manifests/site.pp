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

node 'rctn004.int.othalland.xyz' {
  class { ::letsencrypt:
    email => 'othalla.lf@gmail.com',
  }
  include nginx
  nginx::resource::server { 'tautulli':
    ensure               => present,
    server_name          => ['tautulli', 'tautulli.int.othalland.xyz'],
  }
}

