data "sops_file" "secrets" {
  source_file = "secrets.yml"
}

variable "region" {
  default = "us-east-1"
}
