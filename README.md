# AWS Native CICD Pipeline

This Repo uses all AWS Services to create a cloud native pipeline. It can be modified to start including external services. The Pipeline is built in various stages. The first stage utilizes Terraform validate and tflint, the second stage utilizes Checkov to scan for misconfigurations against best practices, and the third stage is a release stage where the code will be built in production.

## Table of Contents
- [AWS Native CICD Pipeline](#aws-native-cicd-pipeline)
  - [Table of Contents](#table-of-contents)
  - [Step 1](#step-1)
  - [Step 2](#step-2)
  - [Step 3](#step-3)
  - [Testing the Pipeline](#testing-the-pipeline)
  - [Infrastructure](#infrastructure)


## Step 1
Start by cloning the Repo and navigating into the remote_state directory. This directory is where the remote state backend and state locking will be created to store the state for the pipeline.

## Step 2
After building the remote state backend navigate into the terraform directory and modify the base_name and aws_region variables in the variables.tf file. The base_name variable prefixes specific resources so that it create unique and identifiable names.

## Step 3
Run terraform validate, plan, and apply. Once all resources have been built you can verify in the console that your resources have built correctly. 

## Testing the Pipeline
You can test the pipeline using [This Demo Code Repo](https://github.com/CloudBeard/aws-cicd-piepline-demo-code.git) 

*Note this code is simple and may change overtime to test various build stages and features*

## Infrastructure
<img src="./AWS Native CICD Pipeline.svg">
<br>
The Infrastructure consists of AWS CodePipeline as the orchestrator for CodeCommit and CodeBuild.