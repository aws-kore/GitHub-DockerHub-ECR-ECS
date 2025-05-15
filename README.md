![image](https://github.com/user-attachments/assets/ff49bb5d-9f32-4919-af2e-3f464bd453ee)
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

