# Cloud Engineering & Security Portfolio

Hands-on cloud engineering portfolio focused on AWS infrastructure, identity security, and Infrastructure-as-Code using Terraform.

---

## Projects

---

### 1. IAM Security Baseline (Terraform)

**Overview**  
Implemented a least-privilege IAM identity model using Terraform to provision an AWS IAM user and attach a scoped S3 read-only policy. This demonstrates secure-by-default identity provisioning using Infrastructure-as-Code.

---

**Architecture**

```mermaid
flowchart LR
    A["Terraform CLI"] --> B["AWS Provider"]
    B --> C["IAM User: cloud-security-user"]
    C --> D["IAM Policy: S3ReadOnlyPolicy"]
    D --> E["S3 Read-Only Access"]
```
Resources Deployed

IAM User: cloud-security-user
IAM Policy: S3ReadOnlyPolicy (S3 GetObject + ListBucket permissions)
IAM Policy Attachment (User → Policy binding)

Deployment Workflow

terraform init → provider initialization
terraform plan → change validation and drift detection
terraform apply → resource provisioning in AWS

Evidence of Deployment


Terraform Apply Output:

![Terraform Apply](docs/images/terraform-apply.png)

IAM User Created:

![IAM User](docs/images/iam-user-details.png)

IAM Policy JSON:

![IAM Policy](docs/images/iam-policy-json.png)

**Security Design Principles**
- Least privilege IAM (only required S3 actions)
- No administrative or wildcard permissions
- Explicit resource-level policy scoping
- Infrastructure-as-Code enforced identity provisioning
- Fully reproducible Terraform deployments
---

### 2. VPC Network Architecture (Terraform)

**Overview**  
Designed and deployed a basic AWS VPC network using Terraform to demonstrate foundational cloud networking concepts, including subnet segmentation, routing control, and isolated infrastructure design.

---

**Architecture**

```mermaid
flowchart LR
    A["Terraform CLI"] --> B["AWS Provider"]
    B --> C["VPC"]
    C --> D["Public Subnet"]
    C --> E["Private Subnet"]
    D --> F["Internet Gateway"]
    D --> G["Route Table"]
```

Resources Deployed

VPC with custom CIDR block
Public subnet (internet-accessible tier)
Private subnet (isolated workload tier)
Internet Gateway
Route table associations

Deployment Workflow

terraform init → provider initialization
terraform plan → validation of network changes
terraform apply → provisioning of VPC infrastructure

Evidence of Deployment

Terraform apply executed successfully 
![VPC Terraform Apply](docs/images/vpc-terraform-apply.png)

VPC created and visible in AWS console
![VPC Console View](docs/images/vpc-console.png)

Subnets and routing tables properly associated
![Subnet Configuration](docs/images/vpc-subnets.png)


**Security Design Principles**
- Network segmentation between public and private tiers
- Controlled internet exposure via public subnet only
- Private subnet isolation from direct inbound access
- Explicit routing configuration (no implicit networking paths)
- Infrastructure-as-Code enforced network consistency


### 3. CI/CD Pipeline (Terraform Validation)

**Overview**
GitHub Actions pipeline for Terraform validation and infrastructure consistency checks on every commit and pull request.

**Pipeline Steps**
- terraform fmt — formatting validation
- terraform plan — execution dry run
- Automated checks triggered on every push

**Evidence**

GitHub Actions Workflow Run:

![Actions Run](docs/images/cicd-actions-run.png)

Workflow Success:

![Actions Success](docs/images/cicd-actions-success.png)

**Design Principles**
- Shift-left validation — catch errors before apply
- No manual intervention required for validation
- Consistent formatting enforced across all contributors

---

## Tools
AWS | Terraform | GitHub Actions | IAM | Cloud Networking

---

## Focus Areas
- Cloud Security Architecture
- Identity & Access Management
- Infrastructure as Code
- DevOps Security