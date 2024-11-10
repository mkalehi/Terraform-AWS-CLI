# Setup Terraform on Windows 10/11

**Please follow below steps to setup Terraform on Windows Workspace**

1. Setup AWS CLI V2
2. Setup Git Bash
3. Setup VS Code
4. Setup Terraform
5. Test AWS CLI
6. Test Terraform Sample
7. Use of AWS Vault (Optional)

## 1. Setup AWS CLI V2

Please follow the [link](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) to install AWS CLI V2. Once setup is done, please follow the steps below for configuring AWS CLI to interact with an AWS Account. 

(Optional) If you need better security, please use [aws-vault](https://github.com/99designs/aws-vault) instead

1. Configure AWS Default Profile and Credentials

    Run the command below using standard user
    ```bash
    aws configure
    ```
    Provide the relevant details. E.g.,
    ```
    AWS Access Key ID [****************XYZ]:
    AWS Secret Access Key [****************ABC]:
    Default region name [eu-west-2]: eu-west-2
    Default output format [json]: json
    ```

2. Configure AWS Role Profiles with MFA

    Open **~/.aws/config** and append the block below for a given role. Repeat the same for multiple role profiles.

    ```
    [profile default]
    mfa_serial=arn:aws:iam::{{ DEVICE_ID }}:mfa/{{ AWS_LOGIN_ID }}

    [profile MKalehi_Role]
    source_profile = default
    role_arn = arn:aws:iam::{{ ACCOUNT_ID }}:role/MKalehi_Role
    mfa_serial = arn:aws:iam::{{ DEVICE_ID }}:mfa//{{ AWS_LOGIN_ID }}

    ```

    Ensure that the **~/.aws/credentials** are set for [default] profile. If name of *source_profile* in config is not matched in credentials, the temp access token won't be generated while running aws cli resource commands.

## 2. Setup Git Bash

Git Bash comes included as part of the Git For Windows package. Download and install Git For Windows like other Windows applications. Once downloaded find the included *.exe* file and open to execute Git Bash.

## 3. Setup VS Code

Please download latest version from https://code.visualstudio.com/docs/?dv=win64user


## 4. Setup Terraform

Please follow [official-guide](https://developer.hashicorp.com/terraform/install) to setup Terraform on Windows.

## 5. Test AWS CLI

Please run below set of commands to verify that the responses are being as expected.

```bash
## To directly assume Role, instead of using default user profile 
$ export AWS_PROFILE=MKalehi_Role 

## To verify that the MFA is configured correctly and appropriate role is in action
$ aws sts get-caller-identity
Enter MFA code for arn:aws:iam::{{ DEVICE_ID }}:mfa/{{ AWS_LOGIN_ID }}: XXXXXXXX
{
    "UserId": "XXXXXXXX:botocore-session-nnnnnnnn",
    "Account": "{{ ACCOUNT_ID }}",
    "Arn": "arn:aws:sts::{{ ACCOUNT_ID }}:assumed-role/MKalehi_Role/botocore-session-nnnnnnnnn"
}
```

## 6. Test Terraform Sample

Run below set of commands

```bash
export AWS_PROFILE=MKalehi_Role
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## 7. Use of AWS Vault (Optional)

Install AWS Vault for Windows using the link below:

https://github.com/99designs/aws-vault/releases/tag/v7.2.0

Simply download the binary to `C:\aws-vault` folder and set the folder in user's `PATH` environment variable.

How to use? Quite simple. Please perform the steps as below.

```bash
# Add credentials to aws-vault secrets engine
aws-vault add <aws-user-profile>
```
```bash
# Open subshell to assume a Role and run command inside the subshell
aws-vault exec <aws-role-profile>

# OR Execute command/script directly
aws-vault exec <aws-role-profile> -- <command_or_script>
```

## Credits

1. https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
2. https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html
3. https://www.atlassian.com/git/tutorials/git-bash
 


