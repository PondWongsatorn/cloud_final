#!/bin/bash

# ตัวแปรจากการตั้งค่า
read -p "กรุณาใส่ชื่อ VM instance: " INSTANCE
read -p "กรุณาใส่ชื่อ firewall rule: " FIREWALL
read -p "กรุณาเลือกโซนที่ต้องการ (เช่น us-central1-a): " ZONE

# กำหนดตัวแปรที่จำเป็น
INSTANCE_NAME="my-jumphost-instance"  # เปลี่ยนชื่อ Instance ตามที่ต้องการ
REGION="us-central1"  # เปลี่ยน Region ตามที่ต้องการ
SQL_INSTANCE_NAME="my-sql-instance"  # ชื่อ SQL Instance
DATABASE_NAME="mydatabase"  # ชื่อฐานข้อมูล
USER_NAME="myuser"  # ชื่อผู้ใช้ SQL
USER_PASSWORD="mypassword"  # รหัสผ่านผู้ใช้ SQL

# กำหนด Firewall Rules
create_firewall() {
    gcloud compute firewall-rules create $FIREWALL \
        --allow tcp:80 \
        --network default
    echo "Firewall rule $FIREWALL ถูกสร้างเรียบร้อยแล้ว"
}

# 1. การสร้าง Compute Engine Instances
gcloud compute instances create $INSTANCE_NAME \
    --zone=$ZONE \
    --machine-type=e2-micro \
    --image-family=ubuntu-2204-lts \
    --image-project=ubuntu-os-cloud \
    --tags=http-server

create_firewall

# 2. การกำหนด Firewall Rules สำหรับ Virtual Machine
echo "การกำหนด Firewall Rules สำหรับ VM"
gcloud compute firewall-rules create $FIREWALL \
    --allow tcp:80 \
    --source-ranges=0.0.0.0/0 \
    --target-tags=http-server

# 3. การสร้าง Cloud SQL Instances
gcloud sql instances create $SQL_INSTANCE_NAME \
    --database-version=MYSQL_5_7 \
    --tier=db-f1-micro \
    --region=$REGION

# รอจนกว่า instance จะสร้างเสร็จ
echo "กำลังรอให้ Cloud SQL Instance สร้างเสร็จ..."
gcloud sql instances wait-for-ready $SQL_INSTANCE_NAME

# 4. การสร้าง account และการกำหนดสิทธิ์
gcloud sql users create $USER_NAME \
    --instance=$SQL_INSTANCE_NAME \
    --password=$USER_PASSWORD

echo "ผู้ใช้ $USER_NAME ถูกสร้างและตั้งรหัสผ่านแล้ว"

# 5. การกำหนดค่าให้ Application เชื่อมต่อ Cloud SQL ผ่านเครือข่าย
# เปิด Cloud Shell (หมายเหตุ: ต้องทำด้วยตนเองใน Google Cloud Console)
echo "กรุณาเปิด Cloud Shell ใน Google Cloud Console และเชื่อมต่อกับ Cloud SQL Instance โดยใช้คำสั่งต่อไปนี้:"
echo "gcloud sql connect $SQL_INSTANCE_NAME --user=$USER_NAME"

# 6. การใช้ภาษา SQL เพื่อจัดการกับฐานข้อมูลและตารางใน Cloud SQL
# สร้างฐานข้อมูล
gcloud sql query "CREATE DATABASE $DATABASE_NAME;" --instance=$SQL_INSTANCE_NAME --user=$USER_NAME

# สร้างตารางในฐานข้อมูล
gcloud sql query "CREATE TABLE $DATABASE_NAME.users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100));" --instance=$SQL_INSTANCE_NAME --user=$USER_NAME

echo "ฐานข้อมูลและตารางถูกสร้างเรียบร้อยแล้วใน Cloud SQL Instance: $SQL_INSTANCE_NAME"

# หมายเหตุ: สามารถใช้โค้ด SQL อื่น ๆ ในการจัดการกับฐานข้อมูลได้ตามต้องการ
