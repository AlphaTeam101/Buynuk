# Platini Store - Flutter E-commerce App 🛍️

A feature-rich, modern, and high-performance e-commerce mobile application built with Flutter. This project was developed as a deep dive into the Flutter framework, focusing on implementing a scalable, testable, and maintainable codebase using Clean Architecture and BLoC.

## ✨ Key Features & Showcase

This app isn't just a UI clone; it's a fully functional application wired up to a real-world (fake) API, built with a focus on performance, scalability, and a "wow" user experience.

| | |
| :---: | :---: |
| **Home Screen & Dark Mode** | **Product Details & Hero Animation** |
| [**Your GIF/Screenshot Here**] | [**Your GIF/Screenshot Here**] |
| **Login & Checkout** | **Order History & Profile** |
| [**Your GIF/Screenshot Here**] | [**Your GIF/Screenshot Here**] |

### Core Features

* **🔒 Secure Authentication:** Full Login/Register flow with JSON Web Tokens (JWT). Access and refresh tokens are securely stored on the device using `flutter_secure_storage`.
* **✨ Stunning UI & Animations:**
    * **Custom Design System:** Built from scratch with reusable components, typography, colors, and `ThemeExtension` for a consistent look.
    * **Full Dark Mode Support:** A beautiful, animated dark mode toggle.
    * **Fluid Animations:** Extensive use of `flutter_animate` for staggered list animations, `Hero` animations for seamless page transitions, and `AnimatedSwitcher` for stateful UI changes.
* **⚡ High-Performance & Caching:**
    * **Full API Integration:** Consumes the [Platzi Fake Store API](https://fakeapi.platzi.com/en).
    * **Local Caching:** Caches data (like products/categories) locally to reduce network calls, minimize loading times, and provide a snappy, near-offline experience.
    * **Complex UI Layouts:** Uses `CustomScrollView` and `Slivers` for high-performance, complex scrollable screens (like Home and Profile).
* **🔍 Advanced Search & Filtering:**
    * **Debounced Search:** Efficiently handles user input in the search bar, waiting for the user to stop typing before sending an API request.
    * **Filtering:** A functional filter screen (UI) to narrow down product results.
* **🛒 Full E-commerce Flow:**
    * Product catalog, categories, and details.
    * Fully state-managed cart.
    * A multi-step checkout process.
* **💳 Payment Gateway Simulation:**
    * UI and state logic for selecting and simulating payments via PayPal and Stripe (Credit Card).
* **🔔 Push Notifications:**
    * Configured with Firebase Cloud Messaging (FCM) to simulate order confirmation notifications.
* **🚚 Order History & Tracking:**
    * A complete screen for users to view their past orders and simulate tracking an order in progress.

## 🏛️ Architecture & Tech Stack

This project is built on a foundation of modern, scalable, and professional best practices.

* **Architecture:** **Clean Architecture**
    * **`Domain`:** Contains the core business logic, entities, and repository interfaces (contracts).
    * **`Data`:** Implements the repositories and manages data sources (remote API and local cache).
    * **`Presentation`:** Contains the UI (Screens/Widgets) and the State Management (BLoC).
* **State Management:** **BLoC (Bloc Library)**
    * Used to separate business logic from the UI, creating a testable and predictable state.
    * Utilizes `Events` to trigger logic, `States` to represent the UI, and `Blocs` to manage the transformation.

### Key Packages & Technologies

| **Category** | **Technology / Package** |
| :---: | :---: |
| **Core** | Flutter, Dart |
| **State Management** | `flutter_bloc` |
| **Architecture** | Clean Architecture |
| **Networking** | `dio` (for API requests and interceptors) |
| **Functional Error Handling** | `fpdart` (`Either` type for success/failure) |
| **Secure Storage** | `flutter_secure_storage` (for JWT tokens) |
| **UI & Animation** | `flutter_animate`, `flutter_staggered_grid_view` |
| **Service Locator** | `get_it`, `injectable` (for Dependency Injection) |
| **Notifications** | `firebase_messaging` |

## 🔌 API

This project is powered by the [**Platzi Fake Store API**](https://fakeapi.platzi.com/en). A huge thanks to the Platzi team for providing this excellent free resource for developers.

## 🚀 Getting Started

To run this project locally:

1.  **Clone the repository:**
    ```
    git clone [https://github.com/](https://github.com/)[YOUR_USERNAME]/[YOUR_REPO_NAME].git
    ```
2.  **Navigate to the project directory:**
    ```
    cd [YOUR_REPO_NAME]
    ```
3.  **Install dependencies:**
    ```
    flutter pub get
    ```
4.  **Run the app:**
    ```
    flutter run
    ```
    *(Note: For Firebase Push Notifications to work, you will need to set up your own `firebase_options.dart` file.)*

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.
