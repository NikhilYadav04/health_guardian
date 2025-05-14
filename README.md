# 🩺 Health Guardian – Flutter Health Monitoring App

**Health Guardian** is a personal health tracking app developed using Flutter and Firebase. It helps users monitor their daily vitals like heart rate, blood pressure, blood sugar, and weight while providing smart analytics and AI-powered health insights. The app is suitable for individuals who want to keep track of their health on a daily basis, and receive meaningful reports and predictions regarding hypertension, diabetes, and heart disease risks.

# 🚀 Live App Preview

Click below to check the preview of the full UI and features:

🔗 [View the Preview](https://drive.google.com/drive/folders/1LHnMQMwISOPkJXVoLJZVpdEhMhiMAcLo)

## 🔐 Authentication & Profile Setup

Upon launching the app, users are prompted to log in using **email and password authentication**. After successful login, they are guided through a profile setup process where they enter:

- Full Name  
- Age  
- Date of Birth  
- Height (in cm)  
- Gender (Male/Female/Other)  
- Medical History (if they have existing conditions like heart disease, high/low blood pressure, diabetes, or obesity)

This information is stored securely and used to personalize the app experience and risk prediction models.

## 📝 Health Data Entry

Users can track and store their vital stats across four primary categories:

### 1️⃣ Heart Rate
- Users can manually **enter their heart rate in BPM (beats per minute)** every day.
- The app stores daily values for future visualization and average tracking.

### 2️⃣ Blood Pressure
- The form captures:
  - **Systolic pressure (upper number)**
  - **Diastolic pressure (lower number)**
  - **Pulse rate**
- Units used: **mmHg**
- Users can enter this data multiple times a day — like morning, after exercise, etc.

### 3️⃣ Blood Sugar
- The app allows entering sugar levels in **mg/dL**.
- Supports categorizing values as:
  - Before Fasting  
  - After Meals  
  - Early Morning  
  - Random  

### 4️⃣ Weight
- Track your body weight (in kilograms).
- Helps monitor weight trends over time, especially important for obesity-related conditions.

## 📈 Health Analysis (ML-Backed Prediction)

Health Guardian features a special **Analysis Page** that evaluates a user’s risk for:

- **Hypertension**
- **Diabetes**
- **Heart Disease**

Users input lifestyle parameters such as:

- Cigarette consumption
- Alcohol consumption
- Sleep hours
- Stress or anxiety levels

This data is fed into a **machine learning model** that predicts the **risk level**:
- 🟢 **Low Risk**
- 🔴 **High Risk**

These predictions help users be more aware and proactive in maintaining their health.

## 📋 Daily Reports & Averages

If a user logs multiple entries in a single day (e.g., before and after meals), Health Guardian:

- **Automatically averages** the values per day.
- Stores daily reports categorized by:
  - Time of day
  - Health category
- The **Reports Page** displays this information as:
  - Date-wise average heart rate, blood pressure, sugar levels, and weight.
  - Easy to review and share with doctors if needed.

## 📊 History & Visual Analytics

To make data understandable and meaningful, the app includes a **History Page**:

- Health values are visualized using:
  - 📊 **Bar Graphs**
  - 📈 **Line Charts**
- Displays:
  - Daily entries over time
  - Weekly/monthly trends
  - Highlighted max/min/average values for each metric

This empowers users to visually understand how their health evolves over time.

## 🤖 Gemini AI Chatbot Integration

Health Guardian features a **Gemini-powered AI chatbot**, trained to:

- Answer health-related questions  
- Provide instant guidance for general medical doubts  
- Offer mental health support or motivation when needed

The chatbot lives inside the app and provides a friendly, conversational interface.

## 🔔 Reminder Notifications

Users can schedule **daily reminders** to:

- Get notified at a specific time to enter their health data
- Maintain consistency in tracking

Uses `flutter_local_notifications` and `workmanager` to ensure notifications are delivered even in the background.

## 💻 Tech Stack Used

### ➤ Frontend:
- **Flutter** – cross-platform UI toolkit for building native Android & iOS apps.

### ➤ Backend:
- **Firebase** – handles user authentication, Firestore database for storing data, and cloud features.

### ➤ State Management:
- **GetX** – used for managing application logic and reactive UI components cleanly and efficiently.

## 📦 Dependencies & Packages

### 🧩 UI & UX
```yaml
smooth_page_indicator: ^1.2.0+3
percent_indicator: ^4.2.3
lottie: ^3.1.3
pinput: ^5.0.0
flutter_svg: ^2.0.14
font_awesome_flutter: ^10.8.0
fl_chart: ^0.69.0
flutter_spinkit: ^5.2.1
skeletonizer: ^1.4.3
```

### 🔔 Notifications & Background Tasks
```yaml
flutter_local_notifications: ^18.0.0
workmanager: ^0.5.2
```

### 🔥 Firebase Services
```yaml
firebase_ui_firestore: ^1.6.3
firebase_core: ^2.32.0
cloud_firestore: ^4.17.5
firebase_auth: ^4.20.0
```

### 💬 Gemini AI Chatbot
```yaml
flutter_gemini: ^2.0.4
dash_chat_2: ^0.0.21
```

### 💾 Local Storage & Env Management
```yaml
shared_preferences: ^2.3.3
flutter_dotenv: ^5.2.1
```

## 📁 Folder Structure

```
lib/
├── getxControllers/        # GetX controllers for state logic
├── helper/                 # Utility functions like local storage
├── screen/                 # All UI screens
├── services/               # Firebase CRUD and API integrations
├── styling/                # Colors, text styles, constants
└── widgets/                # Reusable custom widgets
```

## 📃 License

This project is licensed under the **MIT License**.  
Feel free to use, modify, and distribute with credit.
