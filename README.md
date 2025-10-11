# 🏥 MIPS Assembly Clinical System

This project is a clinical management system developed in MIPS Assembly, featuring both admin and doctor modes. It serves as a training project to explore MIPS Assembly capabilities for implementing practical applications in a healthcare context.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Modes](#modes)
  - [Admin Mode](#admin-mode)
  - [Doctor Mode](#doctor-mode)
- [Installation](#installation)
- [Usage](#usage)

---

## 📝 Overview

The MIPS Assembly Clinical System provides a full-featured, assembly-based solution for managing patient records, scheduling, and appointment handling. This system operates in two distinct modes:

- **Admin Mode**: Allows admins to manage patient data, schedule appointments, and cancel reservations.
- **Doctor Mode**: Provides doctors with access to view patient records and today's reservations.

---

## ✨ Features

- 🔒 **Admin Authentication**: Allows access to admin functions only after entering the correct password within three attempts.
- 📋 **Patient Record Management**: Add, edit, or update patient records, including viewing specific details based on patient ID.
- ⏰ **Appointment Scheduling**: Reserve or cancel appointments with doctors, manage available time slots, and view daily reservations.
- 👩‍⚕️ **Doctor Mode**: Quickly access patient information and review all reservations for the day.

---

## ⚙️ Modes

### 🛠️ Admin Mode

To access admin features, the user must enter the correct password within the first three attempts; otherwise, the system will block access. Admin mode provides the following options:

1. **Add New Patient**: Register new patients by entering their data and creating a unique ID.
2. **Edit Patient Record**: Modify existing patient records or add additional data using the patient’s unique ID.
3. **Reserve a Slot with the Doctor**: View all available slots and reserve a time slot for a patient based on their ID and desired appointment time.
4. **Cancel Reservation**: Cancel an existing reservation, making the slot available again for others.

### 🩺 Doctor Mode

In doctor mode, access to patient data and daily appointments is available without the need for password verification. Options include:

1. **View Patient Record**: View all stored data for a patient by entering their unique ID.
2. **View Today’s Reservations**: Display all scheduled appointments for the day, enabling quick access to daily reservations.

---

## 🔧 Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/AbdelrahmanAtef01/Clinic-management-system-in-Assembly.git
   ```

2. Ensure you have a MIPS Assembly simulator installed (such as **MARS** or **SPIM**).

3. Open the project in your MIPS simulator and load the main assembly file.

---

## 🚀 Usage

1. Run the program in your MIPS simulator.
2. Follow the on-screen instructions to choose between **Admin Mode** and **Doctor Mode**.
3. In **Admin Mode**, enter the password correctly within the first three attempts to access admin functionalities.
4. Use patient IDs to add, view, edit, or delete records as needed.
5. In **Doctor Mode**, view patient records and today's reservations directly.

