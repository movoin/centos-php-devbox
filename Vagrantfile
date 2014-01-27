# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# Vagrant Config
#
box      = "lnmp-via-puppet"
url      = "file:///E:/vagrant/res/centos-6.5-x86_64-mini.box"
hostname = "lnmp"
domain   = "basebox.com"
memory   = "512"
cpus     = "1"

Vagrant.configure("2") do |config|
  config.vm.box = box
  config.vm.box_url = url
  config.vm.host_name = hostname + "." + domain

  # config.vm.synced_folder "./wwwroot", "/var/www"
  # config.vm.synced_folder "./logs", "/usr/local/logs"

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", memory,
      "--cpus", cpus,
      "--hwvirtex", "on",
      "--hwvirtexexcl", "on",
      "--vtxvpid", "on",
      "--ioapic", "on",
      "--accelerate3d", "off",
      "--natdnsproxy1", "off",
      "--largepages", "on",
    ]
  end

  # SSH
  config.vm.network :forwarded_port,
    guest: 22,
    host: 22,
    host_ip: "127.0.0.1",
    id: "ssh",
    auto_correct: true

  # Nginx
  # config.vm.network :forwarded_port,
  #   guest: 80,
  #   host: 80,
  #   host_ip: "127.0.0.1",
  #   id: "nginx",
  #   auto_correct: true

  # # Jenkins
  # config.vm.network :forwarded_port,
  #   guest: 8000,
  #   host: 8000,
  #   host_ip: "127.0.0.1",
  #   id: "jenkins",
  #   auto_correct: true

  # # MySQL
  # config.vm.network :forwarded_port,
  #   guest: 3306,
  #   host: 3306,
  #   host_ip: "127.0.0.1",
  #   id: "mysql",
  #   auto_correct: true

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
    puppet.options = ["--verbose"]
  end

end
