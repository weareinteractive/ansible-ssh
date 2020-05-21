# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vbguest.no_remote = true
  config.vbguest.auto_update = false

  config.vm.define 'bionic' do |instance|
    instance.vm.box = 'ubuntu/bionic64'
  end

  config.vm.define 'xenial' do |instance|
    instance.vm.box = 'ubuntu/xenial64'
  end

  config.vm.provision "shell", inline: <<-SHELL
  echo "Updating virtual machine..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get update

  echo "Installing prerequisites..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python
  SHELL

  # View the documentation for the provider you're using for more
  # information on available options.
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/main.yml"
    ansible.verbose = 'vv'
  end
end
