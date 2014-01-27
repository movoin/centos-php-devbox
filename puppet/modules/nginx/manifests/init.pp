class nginx {

    include nginx::prepare
    include nginx::install
    include nginx::config

    nginx::config::init { "install":
        cpunumber => $processorcount,
    }

    include nginx::server

}
