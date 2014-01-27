class nginx::config {

    include nginx::params

    define init($cpunumber) {
        file { "${nginx::params::install_path}/conf/nginx.conf":
            content => template("nginx/nginx.conf.erb"),
            require => Class["nginx::install"],
        }

        file { "${nginx::params::install_path}/conf/sites-enabled":
            ensure  => directory,
        }

        file { "${nginx::params::www_path}":
            ensure  => directory,
            owner   => "www",
            group   => "www",
            mode    => "0755",
        }

        file { "${nginx::params::www_path}/index.html":
            owner   => "www",
            group   => "www",
            mode    => "0644",
            source  => "puppet:///modules/nginx/index.html",
            require => File["${nginx::params::www_path}"]
        }
    }

    #
    # Add Virtual host
    #

    define vhost($domain) {
        file { "${nginx::params::www_path}/${domain}":
            ensure  => directory,
            owner   => "www",
            group   => "www",
            mode    => "0755",
        }

        file { "${nginx::params::www_path}/${domain}/index.html":
            owner   => "www",
            group   => "www",
            mode    => "0644",
            source  => "puppet:///modules/nginx/index.html",
            require => File["${nginx::params::www_path}/${domain}"]
        }

        file { "${nginx::params::install_path}/conf/sites-enabled/${domain}.conf":
            content => template("nginx/vhost.conf.erb"),
            require => File["${nginx::params::www_path}/${domain}"],
            notify  => Service["nginx"]
        }
    }

}
