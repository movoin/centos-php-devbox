class mysql::setup {

    include mysql::params

    file { "${mysql::params::data_path}":
        ensure => directory,
        owner => 'mysql',
        group => 'mysql',
        mode  => '0644',
    }

    #
    # Config MySQL
    #

    file { "/etc/my.cnf":
        ensure => file,
        content => template("mysql/my.cnf.erb")
    }

    #
    # Add MySQL Service
    #

    file { "/etc/init.d/mysqld":
        ensure => file,
        owner => 'root',
        group => 'root',
        mode  => '0755',
        source => '/usr/local/src/mysql-5.6.15/support-files/mysql.server'
    }

    exec { 'add-server':
        command => 'chkconfig --add mysqld && chkconfig mysqld on',
        require => File['/etc/init.d/mysqld']
    }

    #
    # Environment $PATH
    #

    exec { 'export-path':
        command => "echo 'export PATH=$PATH:${mysql::params::install_path}/bin' >> /etc/profile && . /etc/profile",
        require => File['/etc/init.d/mysqld']
    }

    #
    # Link MySQL Library
    #

    file { "/usr/lib/libmysqlclient.18.1.0":
        ensure => link,
        source => "${mysql::params::install_path}/lib/libmysqlclient.18.1.0"
    }

    #
    # Init Database
    #

    exec { 'init-db':
        command => "${mysql::params::install_path}/scripts/mysql_install_db --user=mysql --basedir=${mysql::params::install_path} --datadir=${mysql::params::data_path}"
    }
}
