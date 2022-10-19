# AWS Native CICD Pipeline

This Repo uses all AWS Services to create a cloud native pipeline. It can be modified to start including external services.

## Table of Contents
1. [Step 1](#step-1)


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
NOTE TO SELF insert Infra Image and describe what is built.