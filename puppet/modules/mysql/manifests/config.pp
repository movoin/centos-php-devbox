class mysql::config {

    #
    # User & Group
    #

    user { "add mysql user":
        name    => "mysql",
        ensure  => present,
        shell   => "/sbin/nologin",
        require => Group["mysql"]
    }

    group { "mysql": ensure => present }


    #
    # Install MySQL Databases
    #

    exec { "install mysql db":
        cwd     => "${mysql::params::install_path}",
        command => "scripts/mysql_install_db --user=mysql",
        unless  => "test -e /etc/init.d/mysqld",
        require => Exec["build mysql"]
    }


    #
    # my.cnf
    #

    file { "/etc/my.cnf":
        source  => "${mysql::params::install_path}/support-files/my-small.cnf",
        ensure  => "present",
        require => Exec["build mysql"],
    }

}
