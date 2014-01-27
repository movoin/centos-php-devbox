class mysql::server {

    file { "/etc/init.d/mysqld":
        source  => "${mysql::params::install_path}/support-files/mysql.server",
        mode    => "0755",
        ensure  => "present",
        owner   => "root",
        group   => "root",
        require => Class[mysql::install],
    }

    service { 'mysqld':
        ensure  => running,
        enable  => true,
        require => [ Class[mysql::config], File["/etc/init.d/mysqld"] ],
    }


    #
    # MySQL Root Password
    #

    exec { "mysql root password":
        cwd     => "${mysql::params::install_path}",
        path    => "${mysql::params::install_path}/bin",
        command => "mysqladmin -u root password '${mysql::params::root_pwd}'",
        unless  => "mysql -u root -p${mysql::params::root_pwd}",
        require => Service["mysqld"]
    }
}
