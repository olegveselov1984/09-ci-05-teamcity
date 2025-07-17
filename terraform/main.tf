module "vpc-dev" { #название модуля
  source       = "./vpc-dev" 
  env_name_network = "network" #параметры которые передаем
  env_name_subnet  = "subnet" #параметры которые передаем
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

module "module-teamcity-server" {
  #source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-teamcity-server"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.vpc-dev.subnet_id] 
  instance_cores = 4
  instance_memory = 4
  instance_name  = "teamcity-server"
  env_name = "teamcity-server" # Имя одной конкретной ВМ. instance_count не учитывается
  #image_family   = "centos-7"
  #image_family = "jetbrains/teamcity-server"
  #container-image = "cr.yandex/jetbrains/teamcity-server"
  boot_disk_size = 15
  public_ip      = true
  security_group_ids = [
  yandex_vpc_security_group.example.id 
  ]
   labels = { 
     project = "teamcity-server"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "teamcity-agent" {
  #source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-teamcity-agent"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_cores = 2
  instance_memory = 4
  instance_name  = "teamcity-agent"
  env_name = "teamcity-agent"
  # image_family   = "centos-7"
  boot_disk_size = 15
  public_ip      = true
  security_group_ids = [
  yandex_vpc_security_group.example.id 
  ]
   labels = { 
     project = "teamcity-agent"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "module-srv-vm" {
  #source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_cores = 2
  instance_memory = 4
  instance_name  = "srv-vm"
  env_name = "srv-vm"
  image_family   = "centos-7"
  public_ip      = true
  security_group_ids = [
  yandex_vpc_security_group.example.id 
  ]
   labels = { 
     project = "srv-vm"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ.(передали путь к yml файлу и переменную!_ssh_public_key)
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
   vars = {
     ssh_public_key = var.ssh_public_key
   }
}

