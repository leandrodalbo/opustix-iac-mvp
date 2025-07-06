# 🏗️ Infrastructure: Ticketera Dev Environment

## This repository provisions the development infrastructure for the **Ticketera** platform using [Terraform](https://www.terraform.io/).

## 📦 What It Creates

### ✅ Compute

- **EC2 Instance** (Amazon Linux)
  - Public IPv4 address
  - Docker-ready for app/service deployment
  - Port access managed via security group

### ✅ Networking

- **Security Group**
  - Allows inbound access on ports: `80` (HTTP), `443` (HTTPS)
- **Default VPC**
  - Uses AWS default VPC in the specified region
  - Public subnet automatically assigned

### ✅ Database

- **Amazon RDS** (PostgreSQL)
  - Single instance
  - Two logical databases:
    - The first one used by the main API service
    - The secondused by Keycloak for authentication

### ✅ Storage

- **S3 Bucket**
  - Stores event banner images

---
