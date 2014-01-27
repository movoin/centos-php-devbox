class nginx::prepare {

    #
    # Copy Sources
    #

    file { "/tmp/nginx-1.5.8.tar.gz":
        source => "puppet:///modules/nginx/nginx-1.5.8.tar.gz",
    }

    #
    # User & Group
    #

    user { "add-www-user":
        name    => "www",
        ensure  => present,
        shell   => "/sbin/nologin",
        require => Group["www"]
    }

    group { "www": ensure => present }
}
