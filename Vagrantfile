Vagrant.configure("2") do |config|

  # fix for stdin: is not a tty : http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Enable the Puppet provisioner, with will look in manifests
  config.vm.provision :puppet do |puppet|
  puppet.environment = "production"
  #puppet.environment_path = "environments"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
  end

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/wily64"

  # Forward guest port 80 to host port 8888 and name mapping
  config.vm.network :forwarded_port, guest: 80, host: 8888

# Use the following for NFS
#config.vm.network "private_network", ip: "172.28.128.110"
#config.vm.synced_folder "YOUR-LOCAL-DIR", "/var/www/my-site/",  :nfs => true

config.vm.synced_folder "YOUR-LOCAL-DIR", "/var/www/my-site/", owner: "www-data", group: "www-data"
end
