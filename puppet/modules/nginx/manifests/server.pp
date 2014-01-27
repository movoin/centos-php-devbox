class nginx::server {

    file { "/etc/init.d/nginx":
        source      => "puppet:///modules/nginx/Nginx-init",
        mode        => "0755",
        ensure      => "present",
        require     => File[ "${nginx::params::install_path}/conf/nginx.conf" ],
        before      => Service["nginx"]
    }

    service { "nginx":
        ensure      => running,
        enable      => true,
        hasrestart  => true,
        hasstatus   => true,
        subscribe   => [ Class[nginx::install], Class[nginx::prepare], Class[nginx::config] ],
    }

}
