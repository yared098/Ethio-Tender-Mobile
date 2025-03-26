lib/
│── main.dart
│── app.dart
│── core/
│   │── services1/               # Database services
│   │   ├── firebase_service.dart
│   │   ├── mongodb_service.dart
│   │   ├── api_service.dart
│   │   ├── db_service.dart
            supabase_service.dart
│   │── repository/              # Business logic
│   │   ├── product_repository.dart
│   │   ├── auth_repository.dart    # ✅ NEW: Handles authentication
│   │   ├── tender_repository.dart  # ✅ NEW: Handles tender operations
│   │── models/                  # Data models
│   │   ├── product_model.dart
│   │   ├── user_model.dart         # ✅ NEW: User model
│   │   ├── tender_model.dart       # ✅ NEW: Tender model
│   │── viewmodel/               # ViewModels
│   │   ├── product_viewmodel.dart
│   │   ├── auth_viewmodel.dart     # ✅ NEW: Handles authentication state
│   │   ├── tender_viewmodel.dart   # ✅ NEW: Handles tenders and bids
│── views/                     # UI screens
│   │── home_screen.dart
│   │── product_screen.dart
│   │── auth_screen.dart          # ✅ NEW: Login/Register UI
│   │── tender_screen.dart        # ✅ NEW: Show tenders
│   │── bid_screen.dart           # ✅ NEW: Place/view bids
│── utils/
│   │── db_config.dart             # Multi-database configuration



configration set up
1.npm install firebase
2.npm install -g firebase-tools
    if u get error
     rm -rf /home/yared/.nvm/versions/node/v20.18.3/lib/node_modules/firebase-tools

    <!-- permission essues -->
    chmod +x /home/yared/.nvm/versions/node/v20.18.3/bin/firebase


3.firebase login
4.firebase init
5.firebase deploy# Ethio-Tender-Mobile
