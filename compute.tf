resource "random_id" "rav_node_id" {
  byte_length = 2
  count       = var.main_instance_count
}

data "aws_ami" "serv_ami" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "rav_main" {
  count                  = var.main_instance_count
  instance_type          = var.main_instance_type
  ami                    = data.aws_ami.serv_ami.id
  key_name               = aws_key_pair.rav_auth.id
  vpc_security_group_ids = [aws_security_group.rav_sg.id]
  subnet_id              = aws_subnet.rav_public_subnet[count.index].id
  user_data              = templatefile("./main-userdata.tpl", { new_hostname = "rav-main-${random_id.rav_node_id[count.index].dec}" })
  root_block_device {
    volume_size = var.main_vol_size
  }
  tags = {
    Name = "rav-main-${random_id.rav_node_id[count.index].dec}"
  }
  provisioner "local-exec" {
    command = "printf '\n${self.public_ip}' aws_hosts"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sed -i '/^[0-9]/d' aws_hosts"
  }
}

resource "aws_key_pair" "rav_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "null_resource" "grafana_update" {
  count = var.main_instance_count

  provisioner "remote-exec" {
    inline = ["sudo apt upgrade -y grafana && touch upgrade.log && echo 'I updated Grafana' >> upgrade.log"]
  }

  connection {
    type       = "ssh"
    user       = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    host       = aws_instance.rav_main[count.index].public_ip
  }
}

/*esource "aws_auto_scaling_group" "rav_usg" {
    
}*/