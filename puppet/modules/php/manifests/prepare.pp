class php::prepare {

    include php::params

    file { "${php::params::log_path}":
        ensure => directory,
    }

    file { "/tmp/php-5.5.7.tar.gz":
        source => 'puppet:///modules/php/php-5.5.7.tar.gz',
        before => Exec["build php"]
    }

    file { "/tmp/libiconv-1.14.tar.gz":
        source => 'puppet:///modules/php/libiconv-1.14.tar.gz',
        before => Exec["build libiconv"]
    }
}
