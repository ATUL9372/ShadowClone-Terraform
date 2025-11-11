# ⚡️ ShadowClone-Terraform

## 🚀 Overview

**ShadowClone-Terraform** is an advanced, **modular Terraform project** that automates the entire lifecycle of AWS EC2 servers — from **creation** and **configuration** to **snapshot backup** and **instant relaunch** — all powered by your own **custom Bash script**.

The key feature:  

You can deploy any type of server (`Jenkins, Docker, ELK, Wazuh, Grafana, Prometheus stack, Nginx, Hacking related tools, etc.`) simply by editing one file: 
Whatever command/script you define inside `new_bash_script_install.sh`, will **automatically execute** on your newly created EC2 instance.  
So this project isn’t limited to Jenkins — it can automate setup of **any custom application**, **tool**, or **server configuration**.

---

## 💡 Core Idea

- Create fully automated EC2 servers with predefined configurations.
- Take EBS snapshots automatically for backup and reusability.
- Re-launch exact same environment from snapshot instantly.
- Fully modular — each stage (create, snapshot, relaunch) can run independently.

---
🌟 Key Features

🚀 Fully modular architecture — Each module can be applied or destroyed independently
🤖 Script-driven automation — Run any Bash setup automatically on EC2
🧩 Snapshot & AMI recovery — Rebuild environments in seconds
🔐 Auto SSH connection — Connects to EC2 automatically post-creation
💰 Cost-efficient — Destroy idle servers, retain snapshots
🌍 Universal use case — Works with any software installation
🧱 100% Infrastructure as Code (IaC) — Pure Terraform-based automation


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
```

### 🔹 Module 2 – `ec2_snapshot_backup`

**Purpose:**  
Creates a **snapshot-based AMI** from the EC2 instance generated in **Module 1**.

---

**What It Does:**
- Reads the **Instance ID** saved from the previous module  
- Creates an **EBS snapshot** of the running EC2 instance  
- Converts the **snapshot into an AMI (Amazon Machine Image)**  
- Saves the **AMI ID** locally in a file (e.g., `snapshot_id.log`)  
- Allows you to **safely destroy** the EC2 instance afterward to **save costs**

---

**Command:**
```bash
terraform apply -target=module.ec2_snapshot_backup
```
(Optional — to destroy only the EC2 instance)
```bash
terraform destroy -target=module.ec2-server_instances
```

### 🔹 Module 3 – `new_ec2_snapshot_launch`

**Purpose:**  
Launches a **new EC2 instance** directly from the **saved AMI or snapshot ID** — no reinstallation needed.

---

**What It Does:**
- Reads the **AMI/Snapshot ID** from `snpashot_ec2_instance_ids.log`  
- Launches a **pre-configured EC2 instance** instantly  
- All your previous configurations (e.g., **Jenkins**, **Docker**, **Nginx**) are **ready to use** right after launch
- Ideal for disaster recovery or fast environment cloning

---

**Command:**
```bash
terraform apply -target=module.new_ec2_snapshot_launch
```

## 📁 Project Structure

.
├── ec2_instance_ids.log
├── main.tf
├── modules
│   ├── 1_ec2-server
│   │   ├── key_pair.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── security_group.tf
│   │   └── variables.tf
│   ├── 2_ec2_snapshot_backup
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── 3_new_snapshot_ec2
│       ├── key-pair.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── security_group.tf
│       └── variables.tf
├── new_bash_script_install.sh
├── outputs.tf
├── provider.tf
├── README.md
├── snapshot_id.log
├── snpashot_ec2_instance_ids.log
├── terraform.tfvars
└── variables.tf

5 directories, 23 files




