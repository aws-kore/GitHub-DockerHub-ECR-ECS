![image](https://github.com/user-attachments/assets/91ffc83f-3521-4595-b7c9-fe7155fb4980)
1. Open VS Code and Set Up FastAPI
2. Create and Save Dockerfile 
3. Create requirements.txt
4. Create a Simple main.py File 
5. Build Docker Image --------------- docker build -t fastapi . 
5. Open a terminal in VS Code (make sure you're in the DevOps folder)
6. Run Docker Container ----- docker run -d -p 8000:8000 fastapi
7. Stop Container - docker stop <container_id> 
8. View Logs ------------ docker logs <container_id>
9. Create ECR Repository ------- aws ecr create-repository --repository-name fastapi --region us-west-2
10. Authenticate Docker with ECR --------- aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi
11. Tag and Push Docker Image to ECR ------ docker tag fastapi:latest 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
docker push 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
12. Deploy with AWS CloudFormation
---------------------------------------------------------------------------------------------------------------------------------
•	Create ECS with EC2 
•	VPC and Networking:
•	VPC: Use existing or create a new one
•	Subnets: At least two public subnets for high availability
•	Internet Gateway: Attached to VPC for external access
•	Route Tables: Include route to Internet Gateway
•	Security Groups: Allow necessary ports (e.g., 22 for SSH, 80/443 for web)
•	IAM Roles:
•	ECS Instance Role: ecsInstanceRole with EC2 container service policy
•	Task Execution Role: ecsTaskExecutionRole for pulling images and logging
•	ECS Cluster:
•	Type: EC2 launch type
•	Capacity: Backed by EC2 instances (manual or via Auto Scaling Group)
•	EC2 Instances:
•	AMI: Amazon ECS-Optimized AMI
•	User Data: Script to register with ECS Cluster
•	Instance Profile: Attach ECS instance role
•	Task Definition:
•	Family: Logical name for the task
•	Container Image: e.g., NGINX or custom image
•	CPU & Memory: Resource allocation for container
•	Port Mappings: Host and container port configuration
•	Logging: CloudWatch Logs configuration
•	Execution Role: Grants ECS permission to run tasks


