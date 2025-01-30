# # Public Instance
# resource "aws_instance" "debian_pub" {
#   ami                    = "ami-0584590e5f0e97daa" # Debian 12 Free Tier (adjust if needed)
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.mbrav_pub_a.id
#   key_name               = aws_key_pair.mbrav.key_name
#   vpc_security_group_ids = [aws_security_group.public_sg.id]
#
#   tags = {
#     Name = "mbrav-public-debian-instance"
#   }
# }
#
# # Private Instance
# resource "aws_instance" "debian_priv" {
#   ami                    = "ami-0584590e5f0e97daa" # Debian 12 Free Tier (adjust if needed)
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.mbrav_priv_a.id
#   key_name               = aws_key_pair.mbrav.key_name
#   vpc_security_group_ids = [aws_security_group.private_sg.id]
#
#   tags = {
#     Name = "mbrav-private-debian-instance"
#   }
# }
