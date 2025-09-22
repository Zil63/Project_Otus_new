# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  # ========= DynamicWeb =========
  config.vm.define "DynamicWeb" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "DynamicWeb"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.network "forwarded_port", guest: 80,   host: 8080, auto_correct: true
    web.vm.network "forwarded_port", guest: 443,  host: 8443, auto_correct: true
    web.vm.network "forwarded_port", guest: 9100, host: 9100, auto_correct: true # node_exporter
    web.vm.synced_folder "./project", "/home/vagrant/project",
      owner: "vagrant", group: "vagrant",
      mount_options: ["dmode=775,fmode=664"]

    web.vm.provider "virtualbox" do |vbx|
      vbx.name   = "DynamicWeb-Server"
      vbx.memory = 2048
      vbx.cpus   = 2
      vbx.customize ["modifyvm", :id, "--audio", "none"]
    end
  end

  # ========= Monitoring =========
  config.vm.define "Monitoring" do |mon|
    mon.vm.box = "ubuntu/jammy64"
    mon.vm.hostname = "Monitoring"
    mon.vm.network "private_network", ip: "192.168.56.20"
    mon.vm.network "forwarded_port", guest: 9090, host: 9090, auto_correct: true  # Prometheus
    mon.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true  # Grafana
    mon.vm.network "forwarded_port", guest: 9093, host: 9093, auto_correct: true  # Alertmanager
    # UDP/514 не пробрасываем — DynamicWeb пишет логи по host-only на 192.168.56.20:514

    mon.vm.synced_folder "./project", "/home/vagrant/project",
      owner: "vagrant", group: "vagrant",
      mount_options: ["dmode=775,fmode=664"]

    mon.vm.provider "virtualbox" do |vbx|
      vbx.name   = "Monitoring-Server"
      vbx.memory = 2048
      vbx.cpus   = 2
      vbx.customize ["modifyvm", :id, "--audio", "none"]
    end
  end

  # ========= Provision через Ansible (inventory из файла hosts) =========
  config.vm.provision "ansible" do |ans|
    ans.playbook = "prov.yml"
    ans.inventory_path = "hosts"      # используем файл hosts
    ans.verbose  = "v"
    ans.become   = true
    ans.compatibility_mode = "2.0"

    # Ничего не задаём через ans.groups — чтобы не дублировать инвентарь

    ans.extra_vars = {
      ansible_ssh_common_args: "-o StrictHostKeyChecking=no"
    }
  end
end
