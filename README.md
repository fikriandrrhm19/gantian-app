# Gantian - Queue Management Platform for UMKM

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev/)
[![Material 3](https://img.shields.io/badge/Material_3-7D5260?style=flat-square&logo=materialdesign&logoColor=white)](https://m3.material.io/)
[![Figma](https://img.shields.io/badge/Figma-F24E1E?style=flat-square&logo=figma&logoColor=white)](https://www.figma.com/)
![Status](https://img.shields.io/badge/Status-In%20Development-orange?style=flat-square)

A mobile-first queue management app for Indonesian walk-in UMKM such as barbershops, workshops, salons, and local service counters.

The platform streamlines physical waiting friction by allowing customers to join live digital queues on-site via QR code scanning, view real-time estimates, and receive smart lifecycle alerts.

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
* **Application Shell:** Unified `HomeView` utilizing a polished `BottomNavigationBar` to coordinate sub-tab navigation fragments gracefully.
* **Interactive UI Elements:** Floating animations, responsive layout constraints, and a fluid animation controller driving pull-to-refresh skeleton shimmer effects.
* **State-Driven Multi-Filtering:** Robust client-side multi-category filtering coupled with optimized query indexing for granular, real-time catalog discovery.
* **Automated Background Synchronization:** Centralized event-driven polling loop ensuring cross-view data consistency between independent tab components without UI disruption.

## Core Core Platform Capabilities

* **REST API Integration:** Full integration with external endpoints to dynamically fetch, deserialize, and present real-time structured merchant catalogs and live ticket parameters.
* **Persistent Session Management:** Native platform storage implementation caching critical identity markers and authentication records for secure automated auto-login loops.
* **Hardware & System Tooling:** Integrated hardware engine for reactive camera-stream QR parsing alongside standalone background execution workers pushing automated proximity alerts.

## Architectural Design Pattern

The project enforces a strict **Model-View-Controller (MVC)** software architecture paired with unified **ChangeNotifier Providers** to ensure absolute Separation of Concerns (SoC), clean state state propagation, and clean maintenance paths.

### Technology Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter SDK |
| Language | Dart |
| State Management | Provider Pattern |
| Storage Interface | SharedPreferences API |
| Peripheral Modules | Mobile Scanner Engine, Local Notifications Service |
| Typography | Plus Jakarta Sans |

### Extended Directory Layout

```text
lib/
├── components/          # Reusable atom-level UI units & overlays
├── controllers/         # MVC Controllers coordinating system state & API logic
├── models/              # Immutable data blueprints and serialization structures
├── services/            # Infrastructure drivers (Notifications, Native Handlers)
└── views/
    ├── login/           # Identity entry points
    ├── otp/             # Verification matrices
    ├── welcome/         # Onboarding modules
    ├── scan_qr/         # Active camera capture interface
    ├── merchant_detail/ # Dynamic profiles showing operational metrics
    └── home/            # Core shell container
        └── tabs/        # Isolated view layers (Beranda, Antrean, Profil)

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

| OTP Code | Result |
| --- | --- |
| `111111` | Simulates a new user and continues to registration |
| `123456` | Simulates an existing user and opens the main application shell |

This temporary behavior will be replaced by a production authentication service in a future release.

## License

This project is licensed under the MIT License. See the LICENSE file for details.