Clone the code into local repository

To run locally:
Install Visual Studio Code
Install JS Node
Install All the dependencies like for eslint, stylelint, htmlhint , prettier
Install Terraform and AWS CLI
On the terminal run the commmand "aws configure" then provide the access and secret key along with region
To run terraform Change the directory to the terraform folder
Run basic commands of the Terraform:
terraform init
terraform validate
terraform plan
terraform apply

To run on Github:
Upload all the code on the github repository
In which github action file is also included you just need to run it properly
On github secrets must provide AWS_SECRET_KEY, AWS_ACCESS_KEY, AWS_DISTRIBUTION_ID
Then just make some changes then add commit
When You push the code on the main branch it will trigger it
Then First It will reveiw the code like check that the code is prettier etc
If the code review is done correctly then it will start making the infrastructure on AWS
If the infrastructure correct then it will Deploy.