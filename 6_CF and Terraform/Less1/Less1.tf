provider "aws" {
  access_key = "AKIAY4JNO7BXVC6P4GMZ"
  secret_key = "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"
  region = "eu-central-1"
}


resource "aws_instance" "myUbuntu" {
    ami = "ami-05f7491af5eef733a"
    instance_type = "t2.micro"
}
