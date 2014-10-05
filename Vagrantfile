# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

domain = 'dev.mattjbishop.com'

precise32_vm_box_url = 'file:///Users/matt/Boxes/precise32.box'

nodes = [
  { :hostname => 'frontend', :ip => '192.168.0.42', :box => 'precise32', :box_url => precise32_vm_box_url },
  { :hostname => 'database',  :ip => '192.168.0.43', :box => 'precise32', :box_url => precise32_vm_box_url, :ram => 512 }  
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.host_name = node[:hostname] + '.' + domain
      node_config.vm.box_url = node[:box_url]
      node_config.vm.network "private_network", ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      config.vm.provider "virtualbox" do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node_config[:hostname],
          '--memory', memory.to_s
        ]
      end
    end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'puppet/modules'
  end
    
end