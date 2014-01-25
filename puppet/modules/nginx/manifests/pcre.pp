class nginx::pcre {

    include nginx::params

    #
    # Install PCRE
    #

    exec { 'wget-pcre':
        cwd     => '/usr/local/src',
        command => 'wget http://downloads.sourceforge.net/project/pcre/pcre/8.34/pcre-8.34.tar.bz2?use_mirror=softlayer-dal',
        onlyif      => "test -f /usr/local/src/pcre-8.34.tar.bz2 != 0",
        logoutput   => on_failure,
        timeout     => 0,
    } ->
    exec { 'build-pcre':
        cwd     => '/usr/local/src',
        command => 'tar xvf pcre-8.34.tar.bz2 && cd pcre-8.34/ && ./configure && make && make install',
        require => Exec['wget-pcre']
    }
}
