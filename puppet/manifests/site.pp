stage { "pre":
    before => Stage["main"]
}

class { "base":
    stage => "pre"
}

Exec {
    path => [
        "/usr/local/sbin",
        "/usr/local/bin",
        "/usr/sbin",
        "/usr/bin",
        "/sbin",
        "/bin"
    ]
}

File {
    owner => "root",
    group => "root",
    mode  => "0644",
}

#
# Base Config
#

include base

#
# Install MySQL (via `mysql-5.5.35-linux2.6-x86_64`)
#
# Because the compiler installed too slow, and I also didn"t find
# compiler installed can offer me any substantial improvement.
#

include mysql

#
# Install Nginx
#

include nginx
include nginx::config

# Add VHost -> [ dexter.devbox.com ]
nginx::config::vhost { "dexter.devbox.com":
    domain => "dexter.devbox.com",
}

#
# Install PHP 5.4
#

include php
# include php::extends

# # Install `pthreads` Extension
# php::extends::install { "pthreads-0.0.45":
#     name      => "pthreads",
#     version   => "0.0.45"
# }
