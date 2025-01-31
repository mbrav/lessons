

# Main ssh key
resource "aws_key_pair" "main" {
  key_name   = var.setup_prefix
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdfUNk1v+CuCpwMqdWFWw//WNjoxoolDlzbjCp/RcP1 Main key"
  tags = {
    Name   = "${var.setup_prefix}-ssh-key"
    Type   = "Security"
    Domain = "Private"
  }
}
