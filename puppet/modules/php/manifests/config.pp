class php::config {

    include php::params

    file { "${php::params::install_path}/etc/conf.d":
        ensure  => directory,
        require => Class["php::install"],
    }

    file { "${php::params::install_path}/etc/php.ini":
        content => template("php/php.ini.erb"),
        require => Class["php::install"],
        notify => Service['php-fpm']
    }

    file { "${php::params::install_path}/etc/php-fpm.conf":
        content => template("php/php-fpm.conf.erb"),
        require => Class["php::install"],
        notify => Service['php-fpm']
    }

    file { "/etc/init.d/php-fpm":
        source  => "/tmp/php-5.5.7/sapi/fpm/init.d.php-fpm",
        mode => 0755,
        ensure => "present",
        owner => "root",
        group => "root",
        require => Class["php::install"],
    }

    exec { "echo 'export PATH=$PATH:${php::params::install_path}/bin' >> /etc/profile":
        require => Class["php::install"],
    }

}
