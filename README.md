# ⚡️ ShadowClone-Terraform

## 🚀 Overview

**ShadowClone-Terraform** is an advanced, **modular Terraform project** that automates the entire lifecycle of AWS EC2 servers — from **creation** and **configuration** to **snapshot backup** and **instant relaunch** — all powered by your own **custom Bash script**.

You can deploy any type of server (Jenkins, Docker host, Prometheus stack, Nginx, etc.) simply by editing one file:  
`new_bash_script_install.sh`.

---

## 🧩 Modular Architecture

This project is designed around **three Terraform modules**, each performing a specific stage of automation.

### 🔹 Module 1 – `ec2-server_instances`

**Purpose:**  
Creates a new EC2 instance, sets up security, and automatically runs your custom installation script.

**What It Does:**
- Creates a **key pair**, **security group**, and attaches to **default VPC**
- Launches a **new EC2 instance** (AMI, instance type, region configurable)
- Executes the script `new_bash_script_install.sh`
- Automatically:
  - Copies the **public IP**
  - Opens a **new terminal** and connects via **SSH**
  - Saves the **Instance ID** for future snapshots

**Command:**
```bash
terraform apply -target=module.ec2-server_instances
