class mysql {

    include mysql::params

    #
    # User & Group
    #

    group { 'mysql': ensure => present }

    user { 'add-mysql-user':
        name    => 'mysql',
        ensure  => present,
        shell   => '/sbin/nologin',
        require => Group['mysql']
    }

    file { "${mysql::params::log_path}":
        ensure => directory,
        owner => 'mysql',
        group => 'mysql',
        mode  => '0644',
    }

    #
    # Install MySQL
    #

    exec { 'wget-mysql':
        cwd         => '/usr/local/src',
        command     => 'wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.15.tar.gz',
        onlyif      => "test -f /usr/local/src/mysql-5.6.15.tar.gz != 0",
        logoutput   => on_failure,
        timeout     => 0,
    }

    exec { 'build-mysql':
        cwd     => '/usr/local/src',
        command => "tar xzf mysql-5.6.15.tar.gz && cd mysql-5.6.15/ && cmake . -DCMAKE_INSTALL_PREFIX=${mysql::params::install_path} -DMYSQL_DATADIR=${mysql::params::data_path} -DSYSCONFDIR=/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=${mysql::params::install_path}/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DMYSQL_USER=mysql -DWITH_EMBEDDED_SERVER=1 -DDEFAULT_COLLATION=utf8_general_ci && make && make install",
        require => Exec['wget-mysql'],
        logoutput => on_failure,
        timeout => 0,
    }

    include mysql::setup

    #
    # Run MySQL Service
    #

    service { "mysqld":
        ensure => running,
        hasrestart => true
    }

}
