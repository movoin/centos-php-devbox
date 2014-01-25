class baseconfig {

    file { "/usr/local/logs":
        ensure => directory,
    }

    exec { 'yum-makecache':
        command     => '/usr/bin/yum makecache'
    }

    $packages = [
        'gcc',
        'gcc-c++',
        'make',
        'cmake',
        'autoconf',
        'libjpeg-turbo',
        'libjpeg-turbo-devel',
        'libpng',
        'libpng-devel',
        'freetype',
        'freetype-devel',
        'libxml2',
        'libxml2-devel',
        'zlib',
        'zlib-devel',
        'glibc',
        'glibc-devel',
        'glib2',
        'glib2-devel',
        'bzip2',
        'bzip2-devel',
        'gmp',
        'gmp-devel',
        'ncurses',
        'ncurses-devel',
        'curl',
        'libcurl-devel',
        'e2fsprogs',
        'e2fsprogs-devel',
        'krb5-devel',
        'libidn',
        'libidn-devel',
        'openssl',
        'openssl-devel',
        'openldap',
        'openldap-devel',
        'openldap-clients',
        'openldap-servers',
        'libxslt-devel',
        'libevent-devel',
        'libtool',
        'libtool-ltdl',
        'bison',
        'bison-devel',
        'gd-devel',
        'vim-enhanced',
        'pcre-devel',
        'zip',
        'unzip',
        'ntpdate',
        'sysstat',
        'patch',
        'strace',
        'sendmail',
    ]

    @package { $packages:
        ensure => present,
    }

    service { "sendmail":
        ensure => running,
        hasrestart => true,
    }
}
