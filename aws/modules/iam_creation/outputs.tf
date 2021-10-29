output "user_iam_ssh_key" {
  value = aws_iam_user_ssh_key.user
}

output "ssh_key_name" {
  value = aws_key_pair.ssh_key.key_name
}