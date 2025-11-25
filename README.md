# 💰 Pocketly
A cross-platform personal finance management app that helps you track expenses, manage categories, and gain insights into your spending habits. Built with Clean Architecture principles and designed to feel native on both iOS and Android.

## ✨ Technologies
- **Flutter** - Cross-platform mobile framework
- **Supabase** - Backend-as-a-Service (PostgreSQL, Auth, RLS)
- **Riverpod 3.0** - State management with code generation
- **Freezed 3.0** - Immutable data classes and sealed unions
- **GoRouter** - Declarative navigation
- **RevenueCat** - Subscription management
- **Platform-adaptive UI** - Cupertino widgets for iOS, Material for Android

## 🚀 Features
- **Smart expense tracking** with category management
- **Premium features** with trial support via RevenueCat
- **Multi-language support** (English/French)
- **Role-based access control** (user/admin)
- **Offline-first architecture** with local caching
- **Platform-adaptive design** that feels native on iOS and Android
- **Local notifications** for reminders and insights
- **Secure authentication** with Supabase RLS policies

## 📍 The Process
I wanted to build a finance app that actually felt good to use, not another spreadsheet in disguise. Started with Clean Architecture to keep things maintainable as the codebase grows. Went all-in on Riverpod 3.0 for state management with code generation - no more boilerplate! Used Freezed for immutable data models because mutability bugs are the worst. The platform-adaptive UI was crucial: Cupertino widgets on iOS, Material on Android, so it feels native everywhere. Supabase handles the backend with RLS policies keeping data secure. Sure, getting all the code generation working together took some iteration, but now adding features is smooth. Pretty happy with how the architecture turned out - everything has its place!

## 🚦 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- iOS Simulator or Android Emulator
- Supabase account

### Installation
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pocketly
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment variables**
   ```bash
   cp env.example .env
   ```
   Then fill in your Supabase URL, anon key, RevenueCat API key, and logo.dev token.

4. **Set up Supabase**
   - Run the schema: `supabase_schema.sql`
   - Configure authentication providers
   - See `SUPABASE_DEEP_LINK_SETUP.md` for deep linking setup

5. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Development Commands

```bash
# Code generation (after modifying @freezed or @riverpod)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation
dart run build_runner watch

# Analyze code
flutter analyze --no-fatal-infos

# Run tests
flutter test

# Clean build
flutter clean && flutter pub get
```

## 📚 Documentation
- **Architecture Guide**: See `CLAUDE.md` for detailed architecture documentation
- **Error Handling**: `lib/core/errors/ERROR_HANDLING_GUIDE.md`
- **User Feature**: `lib/features/user/README.md`
- **Notifications**: `lib/features/notifications/README.md`
- **Supabase Roles**: `SUPABASE_ROLES_SYSTEM.md`

## 🏗️ Architecture
Built with feature-first Clean Architecture:
- **Domain Layer**: Pure business logic (entities, repositories, use cases)
- **Data Layer**: API integration, local storage, models
- **Presentation Layer**: UI, providers, screens, widgets

Features are isolated modules that communicate through barrel exports and domain interfaces.

## 📱 Platforms
- iOS 12.0+
- Android API 21+

---

Built with ❤️ using Flutter and Clean Architecture
