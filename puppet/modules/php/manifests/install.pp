class php::install {

    include php::params
    include mysql::params

    exec { "build php":
        cwd         => "/tmp",
        command     => "tar zxf php-5.5.7.tar.gz && cd php-5.5.7/ && ldconfig && ./configure --prefix=${php::params::install_path} --with-config-file-path=${php::params::install_path}/etc --with-config-file-scan-dir=${php::params::install_path}/etc/conf.d --with-iconv-dir=/usr/local --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --with-curl --with-mcrypt --with-mhash --with-openssl --with-kerberos --with-gmp --with-gd --with-xsl --with-xmlrpc --with-gettext --with-ldap --with-ldap-sasl --with-fpm-user=www --with-fpm-group=www --enable-cli --enable-cgi --enable-calendar --enable-fpm --enable-inline-optimization --enable-pcntl --enable-mbregex --enable-wddx --enable-shmop --enable-soap --enable-xml --enable-bcmath --enable-exif --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-mbstring --enable-gd-native-ttf --enable-sockets --enable-zip --enable-maintainer-zts --enable-opcache --disable-fileinfo --disable-rpath --disable-ipv6 --disable-debug --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd && make ZEND_EXTRA_LIBS='-liconv' && make install",
        logoutput   => on_failure,
        timeout     => 0,
        require     => [ Class[php::prepare], Class[php::depends] ],
        before      => Exec["export phpbin"]
    }

    exec { "export-phpbin":
        command     => "echo 'export PATH=$PATH:${php::params::install_path}/bin' >> /etc/profile && . /etc/profile",
    }
}
