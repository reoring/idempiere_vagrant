# -*- mode: ruby -*-
# vi: set ft=ruby :
#
require 'yaml'

Vagrant.configure("2") do |config|
  config.vm.hostname = "idempiere"

  config.berkshelf.enabled = true
  
  config.vm.provider :aws do |aws, override|
    config.omnibus.chef_version = :latest
    config.vm.box = "dummy"
    aws.tags = {
      'Name' => 'iDempiere'
    }

    aws_config = YAML.load_file("aws_config.yml")

    aws.access_key_id     = aws_config["aws_access_key"]
    aws.secret_access_key = aws_config["aws_secret_access_key"]
    aws.keypair_name      = "idempiere"
    #aws.security_groups   = %w[sg-cbc0d5a9]

    aws.ami = "ami-6fd25e6e" 
    aws.instance_type = "m1.large"

    aws.region = "ap-northeast-1"

    override.ssh.username = "ec2-user"
    override.ssh.private_key_path = "idempiere.pem"
  end

  config.vm.provider :virtualbox do |vb, override|
    config.vm.box = "CentOS-6.4-x86_64-minimal"
    config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"
    config.vm.network :private_network, ip: "33.33.33.10"
  end

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
