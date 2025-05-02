# AmmarCafe ☕

A modern coffee shop application built with Flutter, featuring both user and admin interfaces. The app provides a seamless experience for ordering coffee and managing the coffee shop's menu.

## Features 🌟

### User Features
- **Authentication** 🔐
  - Email/Password Login
  - Google Sign-in
  - User Registration
  - Password Recovery
  - Automatic login state persistence

- **Home Screen** 🏠
  - Beautiful welcome message
  - Search functionality
  - Categorized coffee display:
    - Hot Coffee ♨️
    - Ice Coffee 🧊
    - Specialty Coffee 🌟
  - Dynamic product grid view

- **Product Features** 🛍️
  - Detailed product view
  - Add to cart functionality
  - Favorite items system
  - Product categories
  - Product search

- **Shopping Cart** 🛒
  - Add/Remove items
  - Adjust quantities
  - Checkout process
  - Order summary

- **User Profile** 👤
  - Personal information display
  - Order history
  - Favorite items list
  - Account settings

### Admin Features 👨‍💼
- **Admin Panel** 
  - Secure admin access
  - Dashboard overview
  - Menu management

- **Category Management** 📁
  - Add new categories
  - Edit existing categories
  - Delete categories
  - Category organization

- **Product Management** 📝
  - Add new products
  - Edit product details
  - Delete products
  - Product image management

## Technical Features 🔧

### Backend Integration
- Firebase Authentication
- Cloud Firestore Database
- Firebase Storage
- Supabase Integration

### State Management
- Provider for state management
- Efficient data handling

### UI/UX Features
- Modern Material Design
- Custom animations
- Responsive layout
- Cross-platform compatibility
- Beautiful UI components
- Custom icons and images

## Screens 📱

1. **Authentication Screens**
   - Login Screen
   - Sign Up Screen
   - Password Reset Screen

2. **Main User Screens**
   - Welcome Screen
   - Home Screen
   - Product Details Screen
   - Cart Screen
   - Favorites Screen
   - Profile Screen

3. **Admin Screens**
   - Admin Panel
   - Category Management
   - Product Management
   - Add/Edit Category
   - Add/Edit Product

## Dependencies 📦

- firebase_core: ^3.10.1
- cloud_firestore: ^5.6.2
- firebase_storage: ^12.4.1
- firebase_messaging: ^15.2.1
- firebase_auth: ^5.4.1
- google_sign_in: ^6.2.2
- provider: ^6.0.0
- image_picker: ^1.1.2
- awesome_dialog: ^3.2.1
- flutter_speed_dial: ^7.0.0
- supabase_flutter: ^2.8.4
- And more...

## Getting Started 🚀

1. Clone the repository
```bash
git clone https://github.com/yourusername/AmmarCafe.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
   - Create a new Firebase project
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Enable Authentication methods (Email/Password and Google Sign-in)
   - Set up Cloud Firestore

4. Run the app
```bash
flutter run
```

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact 📧

For any queries or suggestions, please reach out to [your contact information].
