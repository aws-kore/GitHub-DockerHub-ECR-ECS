![image](https://github.com/user-attachments/assets/090b836d-6ee0-4579-9b09-86b577675754)

                                                                           
Task: Dockerize and prepare for cloud deployment                                                                                                                           
Main Steps: 
1. Create a Dockerfile for the FastAPI application. Use python 3.13
2. Build and tag the Docker image using docker build. 
3. Run the Docker container locally and test access to FastAPI endpoints. 
4. Learn Docker commands: build, run, stop, logs.                                  

Process --------------------------------------------------------------------

## Open VS Code - click folder - create folder name - DevOps 
## On VS Code - click file - name it Dockerfile and paste your code then save 
## Click file - paste your code name it - requirements.txt
## Build and tag Docker image command -  ( docker build -t fastapi . )
## Run the Docker container and test fastapi locally with command - ( docker run -d -p 8000:8000 fastapi)
## Docker stop 4567 (put image no )
## Create you ecr repo
aws ecr create-repository --repository-name fastapi --region us-west-2
## Authenticate your docker to ecr == > gives encrypted password for docker
aws ecr get-login-password --region us-west-2
## Final Authenticate to ecr
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi
## docker tag
## docker tag fastapi:latest 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
## docker push
docker push 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
## Create ECS

