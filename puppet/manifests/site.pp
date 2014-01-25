stage { 'pre':
  before => Stage['main']
}

class { 'baseconfig':
  stage => 'pre'
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
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

include baseconfig
include nginx
include mysql
