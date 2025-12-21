===========================
CLINIC MANAGEMENT SYSTEM
MIPS Assembly Project
===========================

Project Overview
----------------
This is a complete Clinic Management System implemented in MIPS Assembly Language using MARS simulator. 
The system manages patient records using a linked list, appointment reservations using an array, and includes separate modes for Admin, Patient Inquiry, and Pharmacy.

Key Features
------------
- Patient Management (Linked List):
  • Register new patient
  • Modify patient record
  • Delete patient record
  • View patient details

- Appointment System (10 slots):
  • Physical slots (1-5): 9:00 AM to 2:00 PM
  • Online slots (6-10): 2:00 PM to 7:00 PM
  • Book appointment
  • Cancel appointment
  • View slot availability

- Access Modes:
  • Administration Mode (password protected)
  • Patient/User Inquiry Mode
  • Pharmacy Mode (view diagnosis and suggested prescription)

- Pharmacy Module:
  • Search patient by ID and view suggested prescription based on diagnosis
  • View all patient diagnoses

- Persistent Storage:
  • Separate Python tool (clinic_backup.py) provided for permanent backup
  • All patients and reserved appointments saved to clinic_data.json (human-readable)
  • Supports Add, Update, Delete, and View operations
  • Data is never overwritten – always updated

How to Run the Project
----------------------
1. Open MARS simulator
2. Load the .asm file
3. Assemble and Run the program
4. Access modes:
   - Admin: Press 0 (password required)
   - Patient Inquiry: Press 1
   - Pharmacy: Press 2
   - Exit: Press 3

5. For Permanent Backup:
   - After using the MIPS program, double-click on clinic_backup.py
   - Follow prompts to add/update/delete data
   - Data will be saved permanently in clinic_data.json
   - Next time you run the tool, previous data will load automatically

Files Included
--------------
- ClinicManagement.asm          (Main MIPS program)
- clinic_backup.py              (Permanent backup tool - double-click to run)
- clinic_data.json              (Generated backup file - contains all data)
- README.txt                    (This file)

Note for Demo
-------------
- Run the MIPS program and demonstrate all features
- Show clinic_data.json file to prove persistent storage
- Open clinic_backup.py to show how backup is maintained

Developed by: [Your Name]
Roll Number: [Your Roll No]
Date: December 2025

Thank you!