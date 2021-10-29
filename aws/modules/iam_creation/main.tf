resource "aws_iam_user" "user" {
    name = var.username
    path = var.path
}

resource "aws_iam_user_ssh_key" "user" {
  username = aws_iam_user.user.name
  encoding = "SSH"
  public_key = var.public_key
}

resource "aws_key_pair" "ssh_key" {
  key_name = "ssh_key"
  public_key = aws_iam_user_ssh_key.user.public_key
  
}