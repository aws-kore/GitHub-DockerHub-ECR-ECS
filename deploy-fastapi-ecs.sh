#!/bin/bash

# --- CONFIGURATION ---
AWS_REGION="us-east-1"
CLUSTER_NAME="fastapi-cluster"
TASK_DEFINITION_NAME="fastapi-task"
CONTAINER_NAME="fastapi-container"
IMAGE_URI="200799931813.dkr.ecr.us-east-1.amazonaws.com/fastapi-app:latest"
SECURITY_GROUP_ID="sg-0add970778cc7279c"       # your Security Group ID (port 8000 open)
SUBNET_ID="subnet-0527abac60bd4ac1a"            # your public subnet ID
EXECUTION_ROLE_ARN="arn:aws:iam::200799931813:role/ecsTaskExecutionRole"  # must exist

# --- STEP 1: Create ECS Cluster ---
echo "Creating ECS cluster: $CLUSTER_NAME"
aws ecs create-cluster --cluster-name $CLUSTER_NAME --region $AWS_REGION

# --- STEP 2: Register Task Definition ---
echo "Registering ECS task definition: $TASK_DEFINITION_NAME"

cat > taskdef.json <<EOF
{
  "family": "$TASK_DEFINITION_NAME",
  "networkMode": "awsvpc",
  "executionRoleArn": "$EXECUTION_ROLE_ARN",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "containerDefinitions": [
    {
      "name": "$CONTAINER_NAME",
      "image": "$IMAGE_URI",
      "portMappings": [
        {
          "containerPort": 8000,
          "hostPort": 8000,
          "protocol": "tcp"
        }
      ],
      "essential": true
    }
  ]
}
EOF

aws ecs register-task-definition \
  --region $AWS_REGION \
  --cli-input-json file://taskdef.json

# --- STEP 3: Run ECS Task ---
echo "Running ECS Fargate task..."

TASK_ARN=$(aws ecs run-task \
  --cluster $CLUSTER_NAME \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_ID],securityGroups=[$SECURITY_GROUP_ID],assignPublicIp=ENABLED}" \
  --task-definition $TASK_DEFINITION_NAME \
  --region $AWS_REGION \
  --query 'tasks[0].taskArn' --output text)

echo "Waiting for task to start..."

aws ecs wait tasks-running --cluster $CLUSTER_NAME --tasks $TASK_ARN

# --- STEP 4: Get Public IP ---
ENI_ID=$(aws ecs describe-tasks \
  --cluster $CLUSTER_NAME \
  --tasks $TASK_ARN \
  --region $AWS_REGION \
  --query "tasks[0].attachments[0].details[?name=='networkInterfaceId'].value" \
  --output text)

PUBLIC_IP=$(aws ec2 describe-network-interfaces \
  --network-interface-ids $ENI_ID \
  --region $AWS_REGION \
  --query "NetworkInterfaces[0].Association.PublicIp" \
  --output text)

echo "✅ FastAPI app is live at: http://IP:8000"
