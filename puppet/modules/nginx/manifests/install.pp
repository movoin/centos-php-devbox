class nginx::install {

    include nginx::params

    #
    # User & Group
    #

    group { 'www': ensure => present }

    user { 'add-www-user':
        name    => 'www',
        ensure  => present,
        shell   => '/sbin/nologin',
        require => Group['www']
    }

    file { "${nginx::params::log_path}":
        ensure => directory,
        owner => 'www',
        group => 'www',
        mode  => '0644',
    }

    #
    # Install Nginx
    #

    exec { 'wget-nginx':
        cwd         => '/usr/local/src',
        command     => 'wget http://nginx.org/download/nginx-1.5.8.tar.gz',
        onlyif      => "test -f /usr/local/src/nginx-1.5.8.tar.gz != 0",
        logoutput   => on_failure,
        timeout     => 0,
    }

    exec { 'build-nginx':
        cwd     => '/usr/local/src',
        command => "tar xzf nginx-1.5.8.tar.gz && cd nginx-1.5.8/ && ./configure --prefix=${nginx::params::install_path} --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-http_flv_module --with-http_gzip_static_module && make && make install",
        require => Exec['wget-nginx'],
        logoutput => on_failure,
        timeout => 0,
    }

}
