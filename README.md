
## 🚀 Features

- ✅ Modular, reusable code
- ✅ Multi-cloud support with separate directories
- ✅ Remote state backend support (e.g., S3, GCS, Azure Storage, OCI Bucket)
- ✅ Uses Terraform CLI with version pinning
- ✅ Clean separation between environment-specific and cloud-specific configurations
- ✅ Follows best practices for IaC

## 🔧 Requirements

- [Terraform >= 1.4](https://www.terraform.io/downloads.html)
- Cloud provider CLI installed and configured:
  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
  - [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
  - [gcloud CLI](https://cloud.google.com/sdk/docs/install)
  - [OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)

## ⚙️ Usage

Each provider directory (e.g., `aws/`, `azure/`, `gcp/`, `oci/`) contains example environments. To use:

```bash
cd <provider>/<project>/

# Initialize Terraform
terraform init

# Review changes
terraform plan

# Apply infrastructure
terraform apply
