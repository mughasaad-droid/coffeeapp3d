# ☕ Minimal Beans - 3D Coffee & Bakery Shop App

A modern, interactive Flutter application for a premium Coffee, Bakery, Tea, and Juice shop featuring **3D Model Previews**, **Video Backgrounds**, and **Custom Animations**.

---

## ✨ Features

- **🎬 Dynamic Video Welcome Screen**: Fullscreen looping video background (`start.mp4`) with custom animations and typography.
- **🧊 Interactive 3D Product Showcase**: 360° interactive 3D model previews (`.glb` files) powered by `model_viewer_plus` for all products (Coffees, Bakery, Teas, Juices).
- **🎨 Modern & Elegant UI Design**:
  - Material 3 styling.
  - Google Fonts (*Pacifico*, *Lobster*, *Poppins*).
  - Custom curved navigation bars and smooth transition effects.
- **🛒 Smart Shopping Cart**:
  - Real-time price calculation.
  - Dynamic item badge count.
  - Cup size selection (*SMALL*, *MEDIUM*, *LARGE*).
- **🧾 Complete Order Flow**: Order confirmation screen displaying receipt breakdown, estimated preparation time (15–20 mins), and total amount.

---

## 📱 App Screens & Navigation Flow

1. **Splash Screen** (`splash.dart`): Animated GIF splash screen (`Started.gif`).
2. **Start Screen** (`start.dart`): High-definition video background welcome page with animated call-to-action button.
3. **Home Screen** (`home.dart`):
   - Category navigation: **COFFEE**, **BAKERY**, **TEA**, **JUICE**.
   - Interactive 3D model carousel for each product.
   - Price, product title, and one-tap Add to Cart.
4. **Cart Screen** (`cart.dart`): Itemized cart review, cup size picker, dynamic total calculation.
5. **Order Confirmation** (`order.dart`): Order summary receipt with delivery time estimation and quick home navigation.

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/) (Dart SDK ^3.12.2)
- **3D Rendering**: [`model_viewer_plus`](https://pub.dev/packages/model_viewer_plus)
- **Video Playback**: [`video_player`](https://pub.dev/packages/video_player)
- **Typography**: [`google_fonts`](https://pub.dev/packages/google_fonts)
- **Icons**: [`cupertino_icons`](https://pub.dev/packages/cupertino_icons)

---

## 📁 Project Structure

```
coffe/
├── assets/
│   ├── 3d_items/       # 3D GLB model assets (coffe, bak, tea, juc)
│   ├── Started.gif     # Splash screen GIF
│   ├── start.mp4       # Welcome screen background video
│   ├── bakery.png, cof.png, tea.png, juice.png # Category icons
├── lib/
│   ├── main.dart       # App entry point
│   └── screens/
│       ├── splash.dart # Animated Splash Screen
│       ├── start.dart  # Video Background Welcome Screen
│       ├── home.dart   # Main 3D Catalog & Category Screen
│       ├── cart.dart   # Shopping Cart & Size Selection Screen
│       └── order.dart  # Order Summary & Receipt Screen
├── pubspec.yaml        # Asset and dependency configurations
└── README.md           # Project Documentation
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
- An Android Emulator, iOS Simulator, or physical device.

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/mughasaad-droid/coffeeapp3d.git
   cd coffeeapp3d
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

---

## 📄 License
This project is open source and available for personal or educational use.
