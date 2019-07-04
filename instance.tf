provider "aws" {
  region = "${var.AWS_REGION}"
}

resource "aws_instance" "main" {
  ami             = "${var.AMI_ID}"
  instance_type   = "${var.INSTANCE_TYPE}"

  key_name        = "${aws_key_pair.vpn-server-ssh-key.key_name}"

  security_groups = ["${aws_security_group.vpn-connection.name}"]

  provisioner "file" {
    source      = "initial-script.sh"
    destination = "/tmp/initial-script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/initial-script.sh",
      "sudo /tmp/initial-script.sh"
    ]
  }
  connection {
    host        = "${self.public_ip}"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_key_pair" "vpn-server-ssh-key" {
  key_name        = "vpn-server-ssh-key"
  public_key      = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_eip" "vpn" {
  instance        = "${aws_instance.main.id}"
}

output "ip" {
  value = "${aws_eip.vpn.public_ip}"
}