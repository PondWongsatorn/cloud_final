รันอันนี้ก่อนนนนนนนนนนนนนนนนนนนนนนนนนนนนนนนน
# ตัวแปรจากการตั้งค่า
export INSTANCE=my-instance-name          # ตั้งชื่อ VM instance
export FIREWALL=my-firewall-rule-name      # ตั้งชื่อ firewall rule
export ZONE=us-central1-a                  # เลือกโซนที่ต้องการ

รันอันนี้หลังจากรันบนแล้วววววววววววววววววววววววววว
# ดาวน์โหลดไฟล์จาก GitHub
curl -LO https://raw.githubusercontent.com/PondWongsatorn/cloud_final/main/allforone.sh

# เปลี่ยนสิทธิ์ของไฟล์ให้สามารถรันได้
sudo chmod +x allforone.sh

# รันสคริปต์
./allforone.sh

คำอธิบายไม่ต้องอ่านหรอก :
การสร้าง Compute Engine Instances
การสร้าง Instance: ไปที่ Compute Engine เพื่อสร้าง VM instance ใหม่ โดยเลือกโซนและประเภท instance ที่เหมาะสมกับความต้องการ เช่น e2-micro ซึ่งเป็นประเภทที่มีค่าใช้จ่ายต่ำ.
การกำหนด Boot Disk: เปลี่ยน Boot disk ให้เป็น Ubuntu และปรับขนาดให้เป็น 10 GB เพื่อให้เพียงพอสำหรับการใช้งาน.
การกำหนด Firewall: เมื่อสร้าง instance ควรเลือก Allow HTTP traffic เพื่อให้สามารถเข้าถึงผ่าน HTTP ได้.
การกำหนด Firewall Rules สำหรับ Virtual Machine
การสร้าง Firewall Rule: ไปที่ Network Security และสร้าง Firewall rule ใหม่ โดยกำหนดชื่อที่ไม่ซ้ำ และเลือก "All instances in the network" ในส่วนของ Targets.
การตั้งค่า Source Filter: ระบุ source filter เป็น 0.0.0.0/0 เพื่ออนุญาตการเข้าถึงจากทุก IP address.
การกำหนด Protocols and Ports: ในส่วนของ Protocols and ports, ให้เลือก TCP และระบุ port 80 สำหรับ HTTP รวมถึงการกำหนด ICMP ใน Other.
การสร้าง Cloud SQL Instances
การสร้าง Instance: ไปที่ Cloud SQL และเลือกสร้าง SQL instance ใหม่ โดยเลือกตัวเลือกที่มีค่าใช้จ่ายต่ำที่สุด.
การรอสร้าง: รอจนกว่า SQL instance จะถูกสร้างเสร็จสมบูรณ์.
การสร้าง Account และการกำหนดสิทธิ์
การสร้างผู้ใช้ใหม่: ใน Cloud SQL, ไปที่ Users และเลือกเพิ่มบัญชีผู้ใช้ใหม่ โดยระบุอีเมลที่ต้องการใช้.
การกำหนดสิทธิ์: เมื่อสร้างบัญชีผู้ใช้, สามารถกำหนดสิทธิ์ในการเข้าถึงฐานข้อมูลที่ต้องการได้.
การกำหนดค่าให้ Application เชื่อมต่อ Cloud SQL
การเปิด Cloud Shell: ไปที่หน้า Overview ของ Cloud SQL และเปิด Cloud Shell เพื่อใช้คำสั่งในการเชื่อมต่อ.
การใช้โค้ด: ใช้โค้ดที่มีอยู่ในไฟล์เพื่อตั้งค่าการเชื่อมต่อกับ Cloud SQL ผ่านเครือข่าย.
การใช้ภาษา SQL เพื่อจัดการกับฐานข้อมูล
การจัดการฐานข้อมูล: ใช้คำสั่ง SQL เพื่อสร้างฐานข้อมูลและตารางใน Cloud SQL โดยอาจใช้คำสั่งที่อยู่ในไฟล์เดียวกัน.
การใช้คำสั่ง: คำสั่ง SQL ที่ใช้จะช่วยให้สามารถสร้าง, อ่าน, ปรับปรุง และลบข้อมูลในฐานข้อมูลได้ตามที่ต้องการ.
การสร้างกลุ่มของ Virtual Machines
การสร้าง Instance Group: ไปที่ VM instances และเลือกตัวเลือกในการสร้างกลุ่มโดยใช้ instance ที่มีอยู่.
การตรวจสอบกลุ่ม: สามารถไปที่หน้า Compute Engine เพื่อดูและจัดการ instance groups ที่สร้างขึ้น.
การกำหนดค่ากลุ่มให้ทำ Auto-scaling
การแก้ไขกลุ่ม: เลือกกลุ่มที่สร้างขึ้นและทำการแก้ไขเพื่อเปิดใช้งาน Auto-scaling.
การบันทึกการตั้งค่า: บันทึกการตั้งค่าเพื่อให้กลุ่มสามารถปรับขนาดได้ตามความต้องการ.
การเปิดให้ Load Balancer สามารถ Monitor Services
การสร้าง Load Balancer: ใช้โค้ดที่มีอยู่ในการตั้งค่าเพื่อสร้าง Load Balancer ที่สามารถตรวจสอบสถานะของบริการที่กำลังทำงานอยู่.
การอัปโหลดไฟล์ไปเก็บไว้บน Cloud Storage
การสร้าง Bucket: ไปที่ Cloud Storage และสร้าง bucket ใหม่ โดยปฏิบัติตามขั้นตอนต่าง ๆ จนถึงการควบคุมการเข้าถึง.
การอัปโหลดไฟล์: อัปโหลดไฟล์ที่ต้องการไปยัง bucket ที่สร้างขึ้น.