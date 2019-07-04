resource "aws_security_group_rule" "vpn-connection-tcp-ingress" {
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  security_group_id = "${aws_security_group.vpn-connection.id}"
  cidr_blocks       = ["${data.http.whatismyipaddress.body}/32"]
  type              = "ingress"
}

resource "aws_security_group_rule" "ssh-ingress" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.vpn-connection.id}"
  cidr_blocks       = ["${data.http.whatismyipaddress.body}/32"]
  type              = "ingress"
}

resource "aws_security_group" "vpn-connection" {
  name        = "vpn_connection"
  description = "Allow TCP VPN traffic"

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "http" "whatismyipaddress" {
  url = "http://bot.whatismyipaddress.com/"
}