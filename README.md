# Cloud Engineering & Security Portfolio

Hands-on cloud engineering portfolio focused on AWS infrastructure, identity security, and Infrastructure-as-Code using Terraform.

---

## Projects

---

### 1. IAM Security Baseline (Terraform)

**Overview**
Designed and deployed a least-privilege IAM model using Terraform to enforce secure-by-default identity access in AWS.

**Architecture**

```mermaid
flowchart LR
    A["Terraform CLI"] --> B["AWS Provider"]
    B --> C["IAM User: cloud-security-user"]
    C --> D["IAM Policy: S3ReadOnlyPolicy"]
    D --> E["S3 Read-Only Access"]
```
Terraform Resources

IAM User: cloud-security-user
IAM Policy: S3ReadOnlyPolicy
IAM Policy Attachment (User → Policy)
**Deployment Flow**
- terraform init — provider setup
- terraform plan — change validation
- terraform apply — resource provisioning

**Evidence of Deployment**

Terraform Apply Output:

![Terraform Apply](docs/images/iam-terraform-apply.png)

IAM User Created:

![IAM User](docs/images/iam-user-details.png)

IAM Policy JSON:

![IAM Policy](docs/images/iam-policy-json.png)

**Security Design Principles**
- Least privilege IAM access model
- No administrative permissions
- Explicit S3 read-only scoping
- Infrastructure-as-Code enforcement
- Fully reproducible deployments

---

### 2. VPC Network Architecture

**Overview**
Basic AWS VPC design implementing segmented network architecture with public and private subnets.

**Resources**
- VPC with custom CIDR block
- Public and private subnets
- Route tables and routing rules

**Deployment Flow**
- terraform init — provider setup
- terraform plan — change validation
- terraform apply — resource provisioning

**Evidence of Deployment**

Terraform Apply Output:

![Terraform Apply](docs/images/vpc-terraform-apply.png)

VPC Created in AWS Console:

![VPC Console](docs/images/vpc-console.png)

Subnets Created:

![Subnets](docs/images/vpc-subnets.png)

**Security Design Principles**
- Network segmentation between public and private tiers
- Explicit routing rules — no implicit access
- Private subnets isolated from direct internet exposure

---

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