class php::depends {

    Class[php::prepare] -> Class[php::depends]

    #
    # Libiconv
    #

    exec { "build libiconv":
        cwd => "/tmp",
        command => "tar xzf libiconv-1.14.tar.gz && cd libiconv-1.14/ && ./configure --prefix=/usr/local && make && make install",
        logoutput => on_failure,
        timeout => 0,
        require => File["/tmp/libiconv-1.14.tar.gz"],
    }


    #
    # Link Files
    #

    include mysql::params

    exec { "ln -s ${mysql::params::install_path}/include/usr/include/mysql && echo '${mysql::params::install_path}/lib' > /etc/ld.so.conf.d/mysql.conf && echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf && ldconfig": }

    file { "/usr/libmcrypt-config":
        target  => "/usr/local/libmcrypt-config",
        ensure  => link,
        replace => "no",
    }

    file { "/lib64/libpcre.so.0.0.1":
        target  => "/lib64/libpcre.so.1",
        ensure  => link,
        replace => "no",
    }

    exec { "ln-ldap":
        command => "ln -s /usr/lib64/libldap* /usr/lib",
    }

}
