# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "idempiere"
  config.vm.box = "CentOS-6.4-x86_64-minimal"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"
  config.vm.network :private_network, ip: "33.33.33.10"

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
        :java => {
            :oracle => {
                "accept_oracle_download_terms" => true
            }
        },
        :postgresql => {
            :password => {
                :postgres => "md53175bce1d3201d16594cebf9d7eb3f9d"
            }
        }
    }

    chef.run_list = [
        "recipe[idempiere::default]"
    ]
  end
end
