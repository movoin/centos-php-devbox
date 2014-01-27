class mysql::install {

    include mysql::params

    exec { "build mysql":
        creates     => "${mysql::params::install_path}",
        cwd         => "/tmp",
        command     => "/bin/tar xvf mysql-5.5.35-linux2.6-x86_64.tar.gz && mv mysql-5.5.35-linux2.6-x86_64/ ${mysql::params::install_path}/",
        logoutput   => on_failure,
        timeout     => 0,
    }

    exec { "export-mysql":
        command     => "echo 'export PATH=$PATH:${mysql::params::install_path}/bin' >> /etc/profile && . /etc/profile",
        require     => Exec["build mysql"]
    }
}
