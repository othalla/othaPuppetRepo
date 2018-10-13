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
    ensure               => present,
    server_name          => ['tautulli.othalland.xyz'],
    listen_port          => 443,
    ssl                  => true,
    ssl_cert             => '/etc/letsencrypt/live/tautulli.othalland.xyz/fullchain.pem',
    ssl_key              => '/etc/letsencrypt/live/tautulli.othalland.xyz/privkey.pem',
    use_default_location => false,
  }
  -> nginx::resource::location { 'Tautulli_letsencrypt':
    ensure      => present,
    location    => '/.well-known/acme-challenge',
    ssl         => true,
    ssl_only    => true,
    server      => 'tautulli.othalland.xyz',
    www_root    => '/var/www/html',
    index_files => [],
    priority    => 401,
  }
  -> nginx::resource::location { 'Tautulli_root':
    ensure           => present,
    location         => '/',
    ssl              => true,
    ssl_only         => true,
    server           => 'tautulli.othalland.xyz',
    proxy            => 'http://192.168.1.120:8181',
    proxy_set_header => [
      'Host $host',
      'X-Real-IP $remote_addr',
      'X-Forwarded-Host $server_name',
      'X-Forwarded-For $proxy_add_x_forwarded_for',
      'X-Forwarded-Proto $scheme',
      'X-Forwarded-Ssl on'],
    priority         => 402,
  }
}
