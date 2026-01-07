# Zero Setup Flutter

A Flutter project template designed for rapid development with pre-configured tools for state management, database, networking, and more. This setup minimizes boilerplate, allowing you to focus on building features.

## Features

- **State Management**: Riverpod with Flutter Hooks for reactive UI.
- **Database**: Isar for fast, NoSQL local storage.
- **Networking**: Dio with Retrofit for API calls, including logging and connectivity checks.
- **UI**: Responsive Framework, Flex Color Scheme, and animations with Flutter Animate.
- **Utilities**: FPDart for functional programming, Envied for environment variables, and more.
- **Code Generation**: Freezed for immutable models, JSON serialization, and asset generation.
- **Testing**: Mocktail for unit tests.
- **Linting**: Custom lints with Riverpod and Flutter lints.

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio or VS Code with Flutter extensions
- Dart SDK

### Installation

1. Clone the repository:

   ```bash
   git clone <your-repo-url>
   cd zero_setup_flutter
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Generate code (for Freezed, JSON, etc.):

   ```bash
   flutter pub run build_runner build
   ```

4. Run the app:

   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── core/          # App-wide configurations (themes, routers)
├── features/      # Feature-specific modules
├── shared/        # Shared entities, utilities, and domain logic
└── main.dart      # Entry point
```

## Key Dependencies Overview

| Category          | Package                  | Purpose |
|-------------------|--------------------------|---------|
| Navigation       | go_router               | Declarative routing with deep links |
| State Management | hooks_riverpod, flutter_hooks | Reactive state with hooks |
| Database         | isar                     | NoSQL database for local storage |
| Storage          | shared_preferences, flutter_secure_storage | Key-value and secure storage |
| Networking       | dio, retrofit, pretty_dio_logger, connectivity_plus | HTTP client, API generation, logging, and connectivity |
| UI               | flex_color_scheme, responsive_framework, cached_network_image, shimmer, flutter_animate, gap | Theming, responsiveness, image caching, loading effects |
| Utilities        | fpdart, permission_handler, envied | Functional programming, permissions, env vars |
| Logging          | talker, talker_dio_logger, talker_flutter, talker_riverpod_logger | Structured logging across layers |
| Code Generation  | freezed_annotation, json_annotation | Immutable models and JSON handling |

## Setup for Specific Packages

### Riverpod (State Management)

- Use `ProviderScope` in `main.dart` to wrap your app.
- Create providers in `lib/shared/providers/` for global state.

### Isar (Database)

- Initialize Isar in `main.dart`:

  ```dart
  final isar = await Isar.open([YourSchema]);
  ```

- Use collections for CRUD operations.

### Networking with Dio/Retrofit

- Define API interfaces with Retrofit annotations.
- Add interceptors for logging in Dio.

### Environment Variables (Envied)

- Create `.env` files and annotate classes with `@Envied()`.
- Run `flutter pub run build_runner build` to generate accessors.

## Testing

- Write unit tests with Mocktail.
- Run tests: `flutter test`

## Troubleshooting

- **Freezed Build Errors**: Run `flutter pub run build_runner build` after changes. Ensure annotations are correct.
- **Gradle Issues**: For Android builds, check `android/build.gradle` versions.
- **Pub Cache**: If dependencies fail, run `flutter pub cache repair`.

## Contributing

1. Fork the repo.
2. Create a feature branch.
3. Make changes and run tests.
4. Submit a PR.

## License

This project is licensed under the MIT License.

# Lunch the App with Different Environments

```dart
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging  
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor prod -t lib/main_prod.dart
```
