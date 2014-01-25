class nginx {

    include nginx::params
    include nginx::pcre
    include nginx::install
    include nginx::setup
    include nginx::server

    Class["nginx::pcre"] ->
    Class["nginx::install"] ->
    Class["nginx::setup"] ->
    Class["nginx::server"]

}
