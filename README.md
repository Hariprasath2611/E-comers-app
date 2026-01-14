# Ecommerce App

A feature-rich ecommerce application built with Flutter, designed to provide a seamless shopping experience. Needs a Firebase project to run.

## 🚀 Features

### User Features
- **Authentication**: Secure login and registration functionality and google sign in.
- **Product Browsing**: View products with detailed descriptions and images.
- **Shopping Cart**: Add items to cart, manage quantities, and review totals.
- **Checkout**: streamlined checkout process.
- **Profile Management**: Manage user details and view order history.
- **Wishlist**: Save favorite items for later.

### Admin Features
- **Dashboard**: Overview of app performance.
- **Product Management**: Add, edit, and remove products.
- **Order Management**: View and update order statuses.

## 🛠️ Tech Stack

This project leverages a robust modern tech stack:

### Core
- **[Flutter](https://flutter.dev/)**: Cross-platform UI toolkit.
- **[Dart](https://dart.dev/)**: Programming language.

### State Management & Architecture
- **[Flutter Riverpod](https://pub.dev/packages/flutter_riverpod)**: Reactive state management.
- **[Fpdart](https://pub.dev/packages/fpdart)**: Functional programming concepts for better error handling.

### Navigation
- **[GoRouter](https://pub.dev/packages/go_router)**: Declarative routing.

### Backend & Services (Firebase)
- **Firebase Auth**: User authentication.
- **Cloud Firestore**: NoSQL database for real-time data.
- **Firebase Storage**: Asset and image storage.
- **Cloud Functions**: Serverless backend logic.
- **Firebase Messaging**: Push notifications.
- **Firebase Analytics**: User engagement insights.

### UI & UX
- **[Flutter Animate](https://pub.dev/packages/flutter_animate)**: Performant animations.
- **[Shimmer](https://pub.dev/packages/shimmer)**: Loading effects.
- **[Google Fonts](https://pub.dev/packages/google_fonts)**: Custom typography.
- **[Flutter Staggered Grid View](https://pub.dev/packages/flutter_staggered_grid_view)**: Masonry layouts.

### Utilities
- **[Equatable](https://pub.dev/packages/equatable)**: Value equality comparison.
- **[Intl](https://pub.dev/packages/intl)**: Internationalization and formatting.

## 🏁 Getting Started

### Prerequisites
- Flutter SDK installed.
- Firebase project setup with `flutterfire configure`.

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ecommerce_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```
