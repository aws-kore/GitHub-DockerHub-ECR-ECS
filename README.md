![image](https://github.com/user-attachments/assets/090b836d-6ee0-4579-9b09-86b577675754)
Task: Dockerize and prepare for cloud deployment
Main Steps:
1. Create a Dockerfile for the FastAPI application. Use python 3.13
2. Build and tag the Docker image using docker build.
3. Run the Docker container locally and test access to FastAPI endpoints.
4. Learn Docker commands: build, run, stop, logs.
5. Open VS Code - click folder - create folder name - DevOps
6. On VS Code - click file - name it Dockerfile and paste your code then save
7. Click file - paste your code name it - requirements.txt
8. docker build -t fastapi .
9. Run the Docker container fastapi locally with command - ( docker run -d -p 8000:8000 fastapi)
10. Docker stop 4567 (put image no )
Create you ecr repo
aws ecr create-repository --repository-name fastapi --region us-west-2
aws ecr get-login-password --region us-west-2
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi
docker tag fastapi:latest 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
docker push
docker push 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
Create ECS use CloudFormation 

                                                                           


