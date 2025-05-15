![image](https://github.com/user-attachments/assets/cb8a98fc-8dd3-44ca-85c1-7f6233bf693a)
✅ 1. Open VS Code and Set Up Project
Open Visual Studio Code.

Create a new folder named DevOps.

Inside the DevOps folder, create a file named Dockerfile.

✅ 2. Create and Save Dockerfile (Python 3.13 + FastAPI)
Paste the following code in the Dockerfile:

Dockerfile
Copy
Edit
# Use official Python 3.13 image
FROM python:3.13

# Set working directory
WORKDIR /app

# Copy requirement file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY . .

# Expose FastAPI port
EXPOSE 8000

# Run FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
✅ 3. Create requirements.txt
Create a requirements.txt in the same directory and paste:

nginx
Copy
Edit
fastapi
uvicorn
(Add any other dependencies your app needs.)

✅ 4. Create a Simple main.py File (If Not Present)
Create a main.py in the same folder:

python
Copy
Edit
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI running in Docker!"}
✅ 5. Build Docker Image
Open a terminal in VS Code (make sure you're in the DevOps folder), then run:

bash
Copy
Edit
docker build -t fastapi .
✅ 6. Run Docker Container
bash
Copy
Edit
docker run -d -p 8000:8000 fastapi
Check it at: http://localhost:8000

✅ 7. Stop Container
bash
Copy
Edit
docker stop <container_id>
To find the container ID:

bash
Copy
Edit
docker ps
✅ 8. View Logs
bash
Copy
Edit
docker logs <container_id>
✅ 9. Create ECR Repository
bash
Copy
Edit
aws ecr create-repository --repository-name fastapi --region us-west-2
✅ 10. Authenticate Docker with ECR
bash
Copy
Edit
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi
✅ 11. Tag and Push Docker Image to ECR
bash
Copy
Edit
docker tag fastapi:latest 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest

docker push 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
✅ 12. Deploy with AWS CloudFormation
You can now create an ECS Cluster using CloudFormation. Either:

Use the AWS Console → CloudFormation → Create Stack

Or write a YAML/JSON CloudFormation template that sets up:

ECS Cluster

ECS Task Definition

ECS Service

Load Balancer (optional)

IAM Roles


                                                                           


