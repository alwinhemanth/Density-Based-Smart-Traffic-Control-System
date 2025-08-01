# 🚦 Density-Based Smart Traffic Control System

This project is a smart traffic control system that uses vehicle density detection to dynamically allocate green light timing at a 4-way junction. It aims to reduce traffic congestion, optimize signal timing, and enhance road safety.

---

## 📱 Frontend: Flutter  
The user interface is built using Flutter to monitor live signal status, display real-time vehicle counts, and control the system remotely.

---

## 💻 Backend Technologies

- **Language**: Python
- **Framework**: Django
- **Libraries**: OpenCV, NumPy, Pandas
- **Vehicle Detection**: Haarcascade / YOLOv8 (version may vary by branch)
- **Database**: MySQL

---

## 🎯 Features

- ✅ Real-time vehicle detection using video input  
- ✅ Smart traffic light timing based on density  
- ✅ Admin dashboard for manual override and system stats  
- ✅ Fail-safe mode to switch to default timing  
- ✅ Countdown timer and signal animations  
- ✅ Signal status logging and historical data analysis

---

## 🧠 System Architecture

```text
+-------------+       Video Feed       +--------------------+       Signal Output
| Surveillance|  ───────────────────▶  | Vehicle Detection   | ───────────────────▶  Traffic Signal
| Camera(s)   |                       |  + Density Estimation|     
+-------------+                       +--------------------+
                                            │
                                            ▼
                                    +--------------------+
                                    |  Django Backend    |
                                    |  + Traffic Logic   |
                                    +--------------------+
                                            │
                                            ▼
                                  +---------------------+
                                  |   Flutter App UI    |
                                  +---------------------+
