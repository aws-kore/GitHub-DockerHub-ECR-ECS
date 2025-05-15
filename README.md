![image](https://github.com/user-attachments/assets/4512127d-ac39-486a-886d-e1352c1f5438)
Task: Dockerize and prepare for cloud deployment
Main Steps:
1. Create a Dockerfile for the FastAPI application. Use python 3.13
2. Build and tag the Docker image using docker build.
3. Run the Docker container locally and test access to FastAPI endpoints.
4. Learn Docker commands: build, run, stop, logs.
   
1. Open VS Code - click folder - create folder name - DevOps
2. On VS Code - click file - name it Dockerfile and paste your code then save
3. Click file - paste your code name it - requirements.txt
4. docker build -t fastapi .
5. Run the Docker container fastapi locally with command - ( docker run -d -p 8000:8000 fastapi)
6. Docker stop 4567 (put image no )
7. Create you ecr repo
8. aws ecr create-repository --repository-name fastapi --region us-west-2
9. aws ecr get-login-password --region us-west-2
10. aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi
11. docker tag fastapi:latest 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
docker push
12. docker push 200799931813.dkr.ecr.us-west-2.amazonaws.com/fastapi:latest
13. Create ECS use CloudFormation 

                                                                           


