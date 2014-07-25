# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "gini" do |gini|

      # vagrant box add gini box/gini.box
      gini.vm.box = "gini"
      # config.vm.box_url = "http://--/.box"
      gini.vm.network :private_network, ip: "192.168.56.10"
      #gini.vm.boot_timeout = 600

      gini.vm.provider :virtualbox do |gv|
          gv.name = "Gini"
          gv.gui = false
          gv.customize ["modifyvm", :id, "--memory", "1024"]
      end


      gini.vm.provision "docker" do |docker|
      end

  end

  config.vm.define "package" do |package|

      package.vm.box = "package"
      package.vm.network :private_network, ip: "192.168.56.11"
      #package.vm.boot_timeout = 600

      package.vm.provider :virtualbox do |gv|
          gv.name = "Test"
          gv.gui = false
          gv.customize ["modifyvm", :id, "--memory", "1024"]
      end

      # # copy file
      # gini.vm.provision "file" do |file|
      #     file.source = "~/.vimrc"
      #     file.destination = "/home/vagrant/.vimrc"
      # end
      
      # # execute command
      # gini.vm.provision "shell", "path": "shell/init.sh"
      # gini.vm.provision "shell", "inline": "echo Hello, World"

      # # install docker if there's no options
      # gini.vm.provision "docker" do |docker|
      #     # images (array) - A list of images to pull using docker pull. You can also use the pull_images function. See the example below this section for more information.
      #     # version (string) - The version of Docker to install. This defaults to "latest" and will install the latest version of Docker.
      #     # build_image - Build an image from a Dockerfile.
      #     #docker.build_image = 'image:optional-tag', '<full path to Dockerfile on guest>', args: '<build args>'
      #     # pull_images - Pull the given images. This does not start these images.
      #     # run - Run a container and configure it to start on vagrant boot.
      # end
      
      # fix: stdin is not a tty
      package.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      # init vagrant env with shell
      package.vm.provision "shell", privileged: false,  path: "shell/init.sh"

      # docker
      package.vm.provision "docker" do |docker|
          # install docker-enter: enter container without ssh
          docker.pull_images "jpetazzo/nsenter"
          docker.run "jpetazzo/nsenter", args: "-v '/usr/local/bin:/target'"
          # install dev containers
          docker.pull_images "iamfat/mysql"
          docker.pull_images "iamfat/gini-dev"
          docker.run "iamfat/mysql", args: "--name 'mysql' -v '/dev/log:/dev/log' -v '/vagrant/sync:/data' --privileged -v '/vagrant/sync/config/mysql:/etc/mysql' -v '/vagrant/sync/logs/mysql:/var/log/mysql'"
          docker.run "iamfat/gini-dev", args: "--name 'gini-dev' -v '/dev/log:/dev/log' -v '/vagrant/sync:/data' --privileged -v '/vagrant/sync/config/sites:/etc/nginx/sites-enabled' -v '/vagrant/sync/logs/supervisor:/var/log/supervisor' -v '/Vagrant/sync/logs/nginx:/var/log/nginx' --link 'mysql:mysql' -p '80:80'"
      end

  end

end
