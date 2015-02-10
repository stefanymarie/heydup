# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
NODES = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box_url = "~/java.box"

  NODES.times do |n|
    config.vm.define "node#{n+1}" do |node|

      node.vm.box      = "node#{n+1}"
      node.vm.hostname = "node#{n+1}"

      node.vm.provider 'virtualbox' do |vm|
        vm.customize ['modifyvm', :id, '--memory', 2048]
      end

      node.vm.network 'private_network', ip: "192.168.0.1#{n+1}"

      node.vm.network 'forwarded_port', guest: 50070, host: "5007#{n}".to_i
      node.vm.network 'forwarded_port', guest: 50030, host: "5003#{n}".to_i
      node.vm.network 'forwarded_port', guest: 50060, host: "5006#{n}".to_i
      node.vm.network 'forwarded_port', guest: 19888, host: "1988#{n}".to_i
      node.vm.network 'forwarded_port', guest: 8088,  host: "8088#{n}".to_i

      node.vm.provision 'shell', path: 'provision_from_bare.sh'
    end
  end

end
