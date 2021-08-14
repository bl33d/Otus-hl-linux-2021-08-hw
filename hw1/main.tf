resource "yandex_compute_instance" "nginx-node" {
  name = "nginx-node"

  resources {
    cores  = 2
    memory = 2
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 50
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  provisioner "remote-exec" {
    inline = ["echo connection-ready"]

    connection {
      host        = self.network_interface.0.nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -D -i ${self.network_interface.0.nat_ip_address}, -u ubuntu ${path.module}/provision/provision.yml"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# resource "null_resource" "ansible-install" {
#   provisioner "local-exec" {
#     # command = format("ansible-playbook -D -i %s, -u ubuntu ${path.module}/provision/provision.yml",  yandex_compute_instance.nginx-node[*].network_interface.0.nat_ip_address
#     # )
#     )
#   }
#}
