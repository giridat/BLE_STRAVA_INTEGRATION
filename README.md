# 🔧 BLE & Strava Integration

This Flutter project is a technical test demonstrating real-world capabilities across two domains:
1. **Bluetooth Low Energy (BLE)** functionality
2. **Strava OAuth 2.0 integration** and activity fetching

The app is built with clean, modular code and proper error handling, ensuring it works across **Android** and **iOS** platforms.

Strava credentials are securely stored in env file, also ensuring the access token is not exposed to the public it is stored inside secure storage.

---

## 🟦 Part 1: Bluetooth Low Energy (BLE)

### ✅ Features Implemented

- **Cross-Platform BLE Support** using `flutter_reactive_ble`
- **BLE Device Scanning**
    - Toggle start/stop scanning via UI
    - Lists discovered BLE devices with their name and MAC address (or ID)
    - Handles errors gracefully (e.g., Bluetooth off)
- **Device Connection**
    - Tap a device to connect
    - Displays connection state: `connecting`, `connected`, `disconnected`
    - Handles connection errors
- **Service & Characteristic Discovery**
    - Automatically discovers services and characteristics after connection
    - Shows a structured list (Service UUID → Characteristics UUIDs)
- **Characteristic Interactions**
    - ✅ **Read:** Button for readable characteristics, values shown in hex, ASCII, or formatted (e.g., `Battery Level: 85%`)
    - ✅ **Write:** Input field + button for sending string or byte array to writable characteristics
    - ✅ **Subscribe/Unsubscribe:** Real-time updates via notifications/indications, displayed live

---

## 🟧 Part 2: Strava OAuth & Activity Fetch

### ✅ Features Implemented

- **OAuth 2.0 Flow with Strava**
    - Login using Strava credentials
    - Handles user denial or auth errors
    - Access token securely stored in-memory
- **Fetch Recent Activities**
    - Retrieves latest cycling or running activities
    - Parses and displays:
        - Activity name
        - Start date/time (formatted)
        - Distance (km or miles)
        - Duration (HH:mm:ss)
        - Type (Cycling/Running)

---

## 🎥 Demo Videos

### 🔌 Part 1: BLE Functionality Demo
▶️ [Watch BLE Demo Video](https://drive.google.com/file/d/1ZIQWaat9RzH-FZmdM8ZbAL7CNAZczDmC/view?usp=drive_link)

### 🏃 Part 2: Strava Integration Demo
▶️ [Watch Strava Demo Video](https://drive.google.com/file/d/1fsOxw3NfIvdLVH6CGJ35ZFHdebr1DDFF/view?usp=drive_link)

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| `flutter_reactive_ble` | BLE operations |
| `flutter_web_auth_2` / `uni_links` | Strava OAuth |
| `http` | Strava API calls |
| `intl` | Formatting date/time |
| `permission_handler` | Runtime BLE permission management |


---

## 🚀 Getting Started

### 🔧 Setup

1. Clone the repository
2. Run: `flutter pub get`
3. **Android:** Ensure Location + Bluetooth permissions are granted
4. **iOS:** Add BLE permissions in `Info.plist`
5. Add your Strava `client_id` and `client_secret` in `lib/strava_config.dart`

```dart
const String stravaClientId = 'YOUR_CLIENT_ID';
const String stravaClientSecret = 'YOUR_CLIENT_SECRET';
const String redirectUri = 'your.app://redirect';
