# 🏥 Health Hive

Health Hive is a cross-platform healthcare mobile application developed using Flutter and Firebase. The application provides a digital platform where patients can easily search doctors, book appointments, manage appointment queues, and access blood bank information. Doctors can manage appointments and update patient queues while administrators can maintain doctors, users, and blood bank records.

---

## 📱 Features

### 👤 Patient Module
- User Registration & Login
- Google Sign-In
- View Doctor List
- Search Doctors
- View Doctor Details
- Book Appointments
- Appointment Queue Tracking
- Active Appointments
- Appointment History
- Cancel Appointment
- View Blood Bank Information
- Profile Management
- Notifications

### 👨‍⚕️ Doctor Module
- Doctor Registration
- Manage Doctor Profile
- View Appointment Requests
- Accept / Reject Appointments
- Queue Management
- Mark Appointments as Completed

### 🛠 Admin Module
- Manage Users
- Manage Doctors
- Manage Blood Banks
- View Reports

---

# 📸 Screenshots

> Add screenshots inside the `/screenshots` folder and update the paths below.

| Welcome | Login | Home |
|---------|-------|------|
| <img width="338" height="509" alt="image" src="https://github.com/user-attachments/assets/b2d9cdba-aad8-4006-8994-5d39907b0a45" /> | <img width="367" height="481" alt="image" src="https://github.com/user-attachments/assets/2e7896ae-9647-415a-a540-b6b8a1468989" /> | <img width="292" height="409" alt="image" src="https://github.com/user-attachments/assets/d807b9bd-b7d8-4d33-b2c1-49736d9cfaab" />
 

| Doctors | Appointment | Profile |
|----------|-------------|----------|
| <img width="353" height="535" alt="image" src="https://github.com/user-attachments/assets/cb7db2ba-b2fe-49d8-9a46-519e99168eb4" /> | <img width="329" height="480" alt="image" src="https://github.com/user-attachments/assets/72012194-395e-4c87-a949-982e44f27c7c" /> |<img width="286" height="426" alt="image" src="https://github.com/user-attachments/assets/362ba9bb-a1ae-4908-a810-5d0d763cec67" /> |


---

# 🏗 System Architecture

```
Patient
      │
      ▼
Flutter Mobile Application
      │
      ▼
Firebase Authentication
      │
      ▼
Cloud Firestore
      │
      ▼
Doctor Panel / Admin Panel
```

---

# ⚙ Technologies Used

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- GetX State Management
- Persistent Bottom Navigation Bar
- Google Sign-In
- Material Design

---

# 📂 Project Structure

```
lib
│
├── controllers
├── models
├── services
├── utils
├── views
│     ├── authui
│     ├── doctorpanel
│     ├── adminpanel
│     └── userpanel
│
├── widgets
│
└── main.dart
```

---

# 🚀 Installation

Clone the repository

```bash
git clone https://github.com/Haideralimehdi/Health-Hive.git
```

Move into project

```bash
cd Health-Hive
```

Install dependencies

```bash
flutter pub get
```

Run the application

```bash
flutter run
```

---

# 🔥 Firebase Configuration

Create a Firebase project and enable:

- Authentication
- Cloud Firestore
- Firebase Storage

Download:

```
google-services.json
```

Place it inside

```
android/app/
```

---

# 📌 Main Functionalities

- Authentication
- Doctor Registration
- Patient Registration
- Appointment Booking
- Queue Management
- Appointment History
- Notification System
- Blood Bank Module

---

# 🎯 Future Improvements

- Online Video Consultation
- AI Symptom Checker
- E-Prescription
- Payment Gateway Integration
- Chat between Doctor & Patient
- Dark Mode
- Multi-language Support

---

# 👨‍💻 Developed By

**Haider Ali Mehdi**

Final Year Project

Department of Computer Science

University of Gujrat

---

# 📄 License

This project is developed for educational purposes as a Final Year Project.
