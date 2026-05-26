terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Terraform detectará en automático las llaves que guardamos en tu ~/.bashrc
}

# Crear el bucket de S3 para el respaldo de datos del SaaS Cervecero
resource "aws_s3_bucket" "brewery_backups" {
  bucket        = "brewery-saas-backups-angel-garibaldi" # Nombre único para tu laboratorio
  force_destroy = true                                   # Permite borrarlo fácil si destruimos el laboratorio
}

# Habilitar el control de versiones en el bucket (Buena práctica de seguridad)
resource "aws_s3_bucket_versioning" "backups_versioning" {
  bucket = aws_s3_bucket.brewery_backups.id
  versioning_configuration {
    status = "Enabled"
  }
}
