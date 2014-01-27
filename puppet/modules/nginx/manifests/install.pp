class nginx::install {

    include nginx::params

    #
    # Build Nginx
    #

    exec {"build nginx":
        creates     => "${nginx::params::install_path}",
        cwd         => "/tmp",
        command     => "tar xvf nginx-1.5.8.tar.gz && cd nginx-1.5.8/ && ./configure --prefix=${nginx::params::install_path} --without-select_module --without-poll_module --with-http_realip_module --with-http_gzip_static_module --with-http_stub_status_module --without-http_ssi_module --without-http_userid_module --without-http_geo_module --without-http_map_module --without-http_uwsgi_module --without-http_scgi_module --without-http_memcached_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module && make && make install",
        logoutput   => on_failure,
        timeout     => 0,
        require     => Class["nginx::prepare"],
    }

    #
    # Create Nginx Logs Directory
    #

    file { "${nginx::params::log_path}":
        ensure  => directory,
        owner   => "www",
        group   => "www",
        mode    => "0644",
        require => [ Exec["build nginx"], User["www"] ]
    }

}
