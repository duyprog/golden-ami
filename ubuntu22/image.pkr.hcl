packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}
source "amazon-ebs" "ubuntu22" {
  ami_name          = "packer-ubuntu-aws-{{timestamp}}"
  instance_type     = "t2.micro"
  region            = "ap-southeast-1"
  security_group_id = var.security_group_id
  subnet_id         = var.subnet_id
  vpc_id            = var.vpc_id
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  sources = [
    "source.amazon-ebs.ubuntu22"
  ]
  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    user          = "ubuntu"
    ansible_env_vars = [
      "ANSIBLE_SCP_IF_SSH=True"
    ]
    extra_arguments = [
      "-v",
      "--tags=ubuntu22",
      "--scp-extra-args", "'-O'"
    ]
  }
  post-processor "manifest" {
    output = "manifest.json"
  }
}