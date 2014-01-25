class nginx::setup {

    include nginx::params

    #
    # Setup Nginx
    #

    file { ["${nginx::params::install_path}/conf/sites-enabled",
            "${nginx::params::www_path}"]:
        ensure => directory
    } ->
    file { "${nginx::params::install_path}/conf/nginx.conf":
        ensure => file,
        content => template("nginx/nginx.conf.erb")
    } ->
    file { '/etc/init.d/nginx':
        owner => 'root',
        group => 'root',
        mode  => '0755',
        source => 'puppet:///modules/nginx/Nginx-init'
    } ->
    exec { 'add-server':
        command => 'chkconfig --add nginx && chkconfig nginx on',
        require => File['/etc/init.d/nginx']
    } ->
    file { "/etc/logrotate.d/nginx":
        ensure => file,
        content => template("nginx/nginx.logrotate.erb")
    } ->
    exec { 'after-ldconfig':
        command => 'ldconfig',
        require => File['/etc/logrotate.d/nginx']
    }
}
