# docker-geth-lb
docker image for latest geth deployment

Overview
-------

This project provides a means to quickly deploy public-facing Ethereum nodes using [AWS CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html) technology. 

Under the hood we're using [Docker](https://www.docker.com/), your choice of [Geth](https://github.com/ethereum/go-ethereum) or [Parity](https://github.com/paritytech/parity), and an instance of [ethstats](https://github.com/cubedro/eth-netstats) to display real-time information about your deployed nodes.

Caution
--------
The following details steps to deploy live code to *real* infrastructure. **It will cost you real money.** Please take time to understand [Amazon's EC2 pricing](https://aws.amazon.com/ec2/pricing/) before deploying. Always continuously monitor your account to ensure any accrued fees match your expectations.

Prerequisites
-----------------

 - An active Amazon Web Services account ([quick setup guide](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-sign-up-for-aws.html)).
	 - For increased security, it is recommended by Amazon to create AWS Identity and Access Management user credentials for day-to-day interaction with AWS. Please see [this page](https://docs.aws.amazon.com/general/latest/gr/root-vs-iam.html) for a thorough explanation and instructions. Also, be sure to [turn on multi-factor authentication](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html) for any account you create.
 - A key pair registered to your AWS account ([guide here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair)).

Deploying to AWS
-------------------------

- Be sure you've met all the prerequisites.
- Choose your node type:
	- Amazon CloudFormation uses JSON templates to deploy predefined infrastructure. We've created templates for both Geth and Parity. Depending on the type of node you'd like to run, save one of the following to your machine:
	- Geth
		- [geth-deployment.json](https://raw.githubusercontent.com/MyEtherWallet/docker-geth-lb/master/aws-cloudformation/geth-deployment.json)
	- Parity
		- [parity-deployment.json](https://raw.githubusercontent.com/MyEtherWallet/docker-geth-lb/master/aws-cloudformation/parity-deployment.json)

- Visit the [AWS console](https://console.aws.amazon.com) and log into your account.
- Click on the **Services** button at the top to open a dropdown. Under **Management Tools**, click on **CloudFormation**.
- Click the blue **Create Stack** button in the top left.
- Under the **Choose a template** heading, select **Upload a template to Amazon S3** and click **Choose File**. Navigate to and select the geth or parity template you saved previously. Click the blue **Next** button in the bottom right.
- You'll be presented a list of configurable parameters for your CloudFormation stack. Here's each of them and what they mean:
	- **Stack name** 
		- The name of the stack as it will appear in your Amazon account. Name it whatever you'd like.
	- **ETHStatsPassword**
		- The password that will be used to connect to the **ethstats** server. Please choose a secure password and remember it.
	- **ETHStatsServer**
		- The AWS EC2 type that will run the ethstats server. This doesn't have to be very powerful since it won't be handling a large amount of traffic. The **t2.micro** instance is selected by default. 
	- **InstanceType**
		- The AWS EC2 type that will run the Ethereum node. The **t2.medium** instance is selected by default. 
	- **InstanceCount**
		- The number of Ethereum nodes you would like to deploy. 
	- **KeyName**
		- The name of the key pair you configured as a prerequisite.
	- **SSHLocation**
		- The IP address range that can SSH into the EC2 instances. The default is `0.0.0.0/0`.
- Once you are satisfied with your configuration, click the blue **Next** button in the bottom right.
- You should arrive at the **Options** page. For this simple setup, nothing needs to be added here. Click the blue **Next** again. 
- Finally, take a moment to review your configuration. If everything looks good, click **Create** in the bottom right.
- Amazon will now bring the template to life. Wait for the yellow **CREATE_IN_PROGRESS** status to switch to a green **CREATE_COMPLETE** before continuing. 
- Next, click on your newly deployed stack and then click on **Outputs**. You should see two keys, described below:
	- **ETHStatsIP** - The public-facing IP address of the ethstats server. Visit this in your browser to view the status of your Ethereum nodes.
	- **URL** - The public-facing URL used to connect to your Ethereum nodes.

Congratulations! You've just deployed one or more public-facing Ethereum nodes!

Undeploying from AWS
-------------------------
You can delete the infrastructure deployed in the previous step at any time:

- Visit the [AWS console](https://console.aws.amazon.com) and log into your account.
- Click on the **Services** button at the top to open a dropdown. Under **Management Tools**, click on **CloudFormation**.
- Right-click on the name of the deployed stack you'd like to erase. Select **Delete Stack** and affirm at the prompt.
