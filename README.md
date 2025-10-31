# Terraform Codes
# 🚀 Terraform Automated Jenkins AMI Snapshot Workflow

## 🧩 Project Overview

This project automates the **creation, configuration, and snapshotting** of a fully installed **Jenkins Server** on AWS using **Terraform**.  
The idea is to:
1. Launch a new EC2 instance with Jenkins installed (via Bash script or user_data).
2. Wait for the installation to finish.
3. Automatically create a **snapshot-based AMI image** of that Jenkins server.
4. Destroy the instance easly
1. Optionally destroy the instance while keeping the snapshot safe in AWS.
2. Reuse the saved AMI later to instantly launch Jenkins-ready EC2 servers.

This helps achieve **fast environment recovery**, **consistent CI/CD setups**, and **cost optimization** by not keeping idle EC2s running.

---

## 🧱 Project Architecture

### 🔹 **Stage 1 – Launch and Install Jenkins**

| Component | Description |
|------------|--------------|
| **Local Machine** | Runs Terraform configuration (`main.tf`, `variables.tf`, etc.) |
| **AWS Cloud** | Terraform creates an EC2 instance, SSH key, and security group |
| **User Data / Bash Script** | Automatically installs Jenkins and its dependencies |
| **Wait Period (~15 min)** | Ensures complete Jenkins setup before snapshot creation |

> The Terraform apply command provisions all resources and installs Jenkins automatically.

---

### 🔹 **Stage 2 – Create AMI Snapshot**

| Step | Description |
|------|--------------|
| 1 | After ~15 minutes, Terraform (or AWS CLI) creates a **snapshot AMI** of the Jenkins EC2 instance |
| 2 | The AMI ID is saved in a local file (e.g., `jenkins_snapshot_ami.txt`) |
| 3 | The AMI remains safely stored inside AWS (EBS-backed image) |
| 4 | Optionally, Terraform destroys the old EC2 instance to save cost |

---

### 🔹 **Stage 3 – Relaunch from Snapshot**

| Step | Description |
|------|--------------|
| 1 | The saved AMI ID is used to launch a **new EC2 instance** |
| 2 | No installation is required — Jenkins is already configured in the AMI |
| 3 | The new instance is ready to use within seconds |
| 4 | This process can be repeated anytime to create pre-configured Jenkins servers |

---

## 🧩 Files in This Project

| File | Purpose |
|------|----------|
| `main.tf` | Creates EC2, key pairs, security group, and installs Jenkins |
| `ami_snapshot.tf` | Creates AMI snapshot of the running instance |
| `variables.tf` | Declares all variables used in the setup |
| `terraform.tfvars` | Contains real values for variables (e.g., region, instance type) |
| `jenkins_installation.sh` | Script that installs and configures Jenkins |
| `jenkins_snapshot_ami.txt` | Stores the AMI ID after snapshot creation |

---

## ⚙️ Step-by-Step Terraform Workflow & Run

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Terraform Apply
```bash
terraform apply
```

### 3. Terraform Run a Specific Module Only
```bash
terraform apply -target=module.ec2-server_instances
```

### 4. Terraform Destroy Only That Module
```bash
terraform destroy -target=module.ec2-server_instances
```

### 5. Terraform Destroy With Every Modules
```bash
terraform destroy
```

### 6. Terraform List All Module Targets
```bash
terraform state list
```
