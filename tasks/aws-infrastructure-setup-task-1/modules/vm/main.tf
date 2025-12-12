data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*x86_64"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = file(var.ssh_public_key_path)
}

resource "aws_instance" "vm_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id = var.subnet_public_id
  vpc_security_group_ids = [var.security_group_id]
  key_name = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true

  provisioner "file" {
    source = "${path.root}/index.html"
    destination = "/tmp/index.html"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file(var.ssh_private_key_path)
      host = self.public_ip
    }
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nfs-utils",
      "sudo mkdir -p /mnt/efs_copy",

      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${var.efs_mount_target_ip_address}:/ /mnt/efs_copy",
      "sudo cp /tmp/index.html /mnt/efs_copy/index.html",
      "sudo chmod -R 777 /mnt/efs_copy",
      "sudo umount /mnt/efs_copy"
    ]
    
     connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file(var.ssh_private_key_path)
      host = self.public_ip
    }
  }

  tags = {
    Name = "vm_instance"
  }
}