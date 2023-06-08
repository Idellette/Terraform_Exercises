# Iteration avec l'argument count
resource "aws_iam_user" "users_count" {
  count = 3
  name  = "user${count.index}"
}

# Iteration avec foreach
resource "aws_iam_user" "users_foreach" {
  for_each = toset(var.user_names)
  name     = each.value
}

variable "user_names" {
  type        = list(string)
  default     = ["asterix", "obelix", "idefix"]
}

