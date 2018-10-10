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
  class { ::nginx:
    confd_purge  => true,
    server_purge => true,
  }
  class { ::letsencrypt:
    email => 'othalla.lf@gmail.com',
  }
  letsencrypt::certonly { 'tautulli.othalland.xyz':
    domains         => ['tautulli.othalland.xyz'],
    plugin          => 'standalone',
    additional_args => ['--preferred-challenges http'],
  }
  nginx::resource::server { 'tautulli.othalland.xyz':
    ensure      => present,
    server_name => ['tautulli.othalland.xyz'],
    listen_port => 443,
    ssl         => true,
    ssl_cert    => '/etc/letsencrypt/live/tautulli.othalland.xyz/fullchain.pem',
    ssl_key     => '/etc/letsencrypt/live/tautulli.othalland.xyz/privkey.pem',
  }
}

