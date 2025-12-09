# alloy-elee-tf
alloy take home assessment 

the terraform code is set up currently with three branches called "prod-us-east-1", "dev-us-east-1" and "staging-us-east-1". these three branches are used to test , pre-production and production use.

another way we could also split the terraform repos up by is by aws components that dont need to be changed very often ( network conpenets) such as VPC, subnets, databases, kms and such where these services will cause major issues if deleted or modified by accident. the other types of aws services would be such as ec2, s3, security groups and etc where these should be changed often and are easily reversable if needed. 


- Compute infrastructure within AWS that an application could eventually run on.
    - Spun up an ec2 server, made it a loop so if we need more instances in the future it is easier to spin up and much cleaner code
    - currently the security group is restricted, we can open this up to what is needed such as SSH from a jumphost and such
    - try and to keep tagging consistent
    - encryption should be enabled for ebs volumes or any type of storage
    - unclear whether this instance needs internet access or need to be publicly exposed. so i gave it no public IP and put it in a private subnet (can be changed if needed)
    - unclear what instance type is 
    - ami -  i am using the latest ami from amazon for now but this should be a golden image of some sort. 
    - iam profile - unclear wheater it needs access to certain aws servives such as s3, secrets manager or anything else. 
    - key name - i am going to pretend we have a ssh public and private key for connection to the instance. did not create this but i put a value in there to assume we have one already



-  A data store in AWS, that the compute infrastructure can communicate with.
    - for the RDS postgres instance that i spun up, ideally, it should be multi-az for high availability
    - data should be encrypted by a customer owned kms key
    - security group rule should only allow port 5432 which is postgres IP from required servers 
    



- Some things to note and unclear
    - backend for statefiles? should be stored in a s3 and dynamodb
    - role for terraform? we need a user and a role to assume
    - what type of data store to use
    - i would like to enable flowlogs for logging within vpc and send this to cloudwatch or s3 but was not stated but still enabled this for vpc.
    - i created a kms key because we should have our data encrypted for both DB and EBS 
    - key for ec2 instance for ssh access
    - does ec2 require ssm access or internet access?
    - added tagging for resources
