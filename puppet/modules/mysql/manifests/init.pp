class mysql {

    Class[mysql::prepare] ->
    Class[mysql::install] ->
    Class[mysql::config] ->
    Class[mysql::server]

    include mysql::prepare
    include mysql::install
    include mysql::config
    include mysql::server

}
