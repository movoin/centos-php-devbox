class php::server {
    service { 'php-fpm':
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        subscribe => [ Class[php::install], Class[php::prepare], Class[php::config] ],
    }
}
