# Gantian - Queue Management Platform for UMKM

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev/)
[![Material 3](https://img.shields.io/badge/Material_3-7D5260?style=flat-square&logo=materialdesign&logoColor=white)](https://m3.material.io/)
[![Figma](https://img.shields.io/badge/Figma-F24E1E?style=flat-square&logo=figma&logoColor=white)](https://www.figma.com/)
![Status](https://img.shields.io/badge/Status-In%20Development-orange?style=flat-square)

A mobile-first queue management app for Indonesian walk-in UMKM such as barbershops, workshops, salons, and local service counters.

The current repository focuses on the authentication flow, user registration, reusable UI components, and the initial application shell.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/c524eee8-9fd4-43e4-97eb-026ab6bf4bd5"
    alt="Gantian App Demo"
    width="280"
  />
</p>

Figma Design File: [Gantian Mobile Workspace](https://www.figma.com/design/4dznk5E1MJMSJXiNJD95JS/Gantian-App-Mobile?node-id=42-2&t=kJxMV6Q4MYY1dcve-1)

## Implementation Highlights

* **OTP Verification Flow:** Custom 6-digit OTP input with clipboard paste support, automatic focus handling, and keyboard navigation improvements.
* **Form Validation:** Input validation using RegEx constraints, character limits, and contextual error messaging.
* **Reusable Components:** Shared UI elements such as `PrimaryButton`, `BackButtonCustom`, and toast notifications to maintain consistency across screens.
* **Custom Toast Overlay:** Lightweight top-positioned notification component built with Flutter overlays.
* **Application Shell:** HomeView with BottomNavigationBar and modular placeholders for future queue management features.
* **Modular Screen Architecture:** Authentication, registration, and home modules organized into isolated feature directories.
* **Interactive UI Elements:** Floating animations and subtle micro-interactions to improve user experience.

## Frontend Architecture

The project follows a modular Flutter structure that separates reusable UI components from screen-level views and navigation logic.

### Technology Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter |
| Language | Dart |
| UI System | Material 3 |
| Typography | Plus Jakarta Sans |

### Directory Layout

```text
lib/
├── components/          # Shared reusable UI components
├── views/
│   ├── login/           # Authentication screens
│   ├── otp/             # OTP verification flow
│   ├── welcome/         # User registration
│   └── home/            # Application shell
│       └── tabs/        # Home, Queue, and Profile placeholders
└── main.dart            # App entry point and theme configuration
```

## Getting Started

### Prerequisites

* Flutter SDK
* Android Studio or VS Code with the Flutter extension
* An emulator, simulator, or physical device

### Clone the Repository

```bash
git clone https://github.com/fikriandrrhm19/gantian-app.git
cd gantian-app
```

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

## Demo Authentication Flow

To simplify local testing, the current authentication flow uses predefined OTP values instead of a live authentication service.

| OTP Code | Result                                                          |
| -------- | --------------------------------------------------------------- |
| `111111` | Simulates a new user and continues to registration              |
| `123456` | Simulates an existing user and opens the main application shell |

This temporary behavior will be replaced by a production authentication service in a future release.

## License

This project is licensed under the MIT License. See the LICENSE file for details.