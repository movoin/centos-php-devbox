class base {

    file { "/usr/local/logs":
        ensure => directory,
    }

    schedule { "daily":
        period => daily,
        range  => [ "00:00-23:59" ],
        repeat => 1,
    }

    exec { "yum-makecache":
        command     => "yum makecache",
        schedule    => "daily",
    }

    $packages = [
        "gcc", "gcc-c++", "autoconf", "automake", "libtool", "make", "zlib", "zlib-devel", "openssl", "openssl-devel", "pcre-devel", "vim-enhanced", "zip", "unzip", "lrzsz",
        "sysstat", "strace", "libjpeg-turbo", "libjpeg-turbo-devel", "libpng", "libpng-devel",
        "freetype", "freetype-devel", "libxml2", "libxml2-devel", "glibc", "glibc-devel",
        "glib2", "glib2-devel", "bzip2", "bzip2-devel", "gmp", "gmp-devel", "ncurses", "ncurses-devel",
        "curl", "libcurl-devel", "e2fsprogs", "e2fsprogs-devel", "krb5-devel",
        "libidn", "libidn-devel", "openldap", "openldap-devel", "openldap-clients",
        "openldap-servers", "libxslt-devel", "libevent-devel", "libtool-ltdl",
        "bison", "bison-devel", "gd-devel","libmcrypt", "libmcrypt-devel", "mhash",
        "mhash-devel", "mcrypt"
    ]

    package { $packages:
        require => Exec["yum-makecache"],
        ensure  => present,
    }
}
