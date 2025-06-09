#!/bin/bash

# Set region and name prefix
REGION="us-east-1"
NAME="fastapi"

echo "Creating VPC..."
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --region $REGION \
  --query "Vpc.VpcId" \
  --output text)

aws ec2 create-tags --resources $VPC_ID --tags Key=Name,Value=${NAME}-vpc --region $REGION
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support "{\"Value\":true}" --region $REGION
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames "{\"Value\":true}" --region $REGION

echo "Creating public subnet..."
SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block 10.0.1.0/24 \
  --availability-zone ${REGION}a \
  --region $REGION \
  --query "Subnet.SubnetId" \
  --output text)

aws ec2 create-tags --resources $SUBNET_ID --tags Key=Name,Value=${NAME}-subnet --region $REGION

echo "Creating Internet Gateway..."
IGW_ID=$(aws ec2 create-internet-gateway \
  --region $REGION \
  --query "InternetGateway.InternetGatewayId" \
  --output text)

aws ec2 attach-internet-gateway \
  --internet-gateway-id $IGW_ID \
  --vpc-id $VPC_ID \
  --region $REGION

echo "Creating Route Table..."
ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id $VPC_ID \
  --region $REGION \
  --query "RouteTable.RouteTableId" \
  --output text)

aws ec2 create-route \
  --route-table-id $ROUTE_TABLE_ID \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id $IGW_ID \
  --region $REGION

aws ec2 associate-route-table \
  --route-table-id $ROUTE_TABLE_ID \
  --subnet-id $SUBNET_ID \
  --region $REGION

echo "Modifying subnet to auto-assign public IPs..."
aws ec2 modify-subnet-attribute \
  --subnet-id $SUBNET_ID \
  --map-public-ip-on-launch \
  --region $REGION

echo "Creating Security Group..."
SG_ID=$(aws ec2 create-security-group \
  --group-name ${NAME}-sg \
  --description "Allow port 8000" \
  --vpc-id $VPC_ID \
  --region $REGION \
  --query "GroupId" \
  --output text)

echo "Opening port 8000 (FastAPI)..."
aws ec2 authorize-security-group-ingress \
  --group-id $SG_ID \
  --protocol tcp \
  --port 8000 \
  --cidr 0.0.0.0/0 \
  --region $REGION

echo ""
echo "✅ Done! Use the following values in your ECS deploy script:"
echo "VPC ID: $VPC_ID"
echo "Subnet ID: $SUBNET_ID"
echo "Security Group ID: $SG_ID"
