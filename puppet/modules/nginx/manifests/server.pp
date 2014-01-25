class nginx::server {

    include nginx::params

    #
    # Run Nginx Server
    #

    service { "nginx":
        ensure => running,
        hasrestart => true
    } ->
    file { "${nginx::params::www_path}/index.html":
        owner => 'www',
        group => 'www',
        mode  => '0644',
        source => 'puppet:///modules/nginx/index.html',
        require => Service["nginx"]
    }
}
