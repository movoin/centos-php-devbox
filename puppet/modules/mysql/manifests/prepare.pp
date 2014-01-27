class mysql::prepare {

    file { "/tmp/mysql-5.5.35-linux2.6-x86_64.tar.gz":
        source  => "puppet:///modules/mysql/mysql-5.5.35-linux2.6-x86_64.tar.gz",
        before  => [ Package["libaio"] ],
    }

    package { "libaio":
        ensure  => installed,
    }

}
