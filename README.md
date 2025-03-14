# Ability Drive Flutter

Ability Drive is a Flutter application designed to provide a seamless ride-sharing experience. This project is developed using Flutter and includes various features to cater to both drivers and passengers.

## Table of Contents
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Code Style](#code-style)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Prerequisites
- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- JDK 17: Ensure you have JDK 17 installed. [Download JDK 17](https://www.oracle.com/java/technologies/javase-jdk17-downloads.html)
- IDE: Visual Studio Code or Android Studio (with Flutter and Dart plugins)

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/Hosny-Mohammed/ability_drive_flutter.git
    ```
2. Navigate to the project directory:
    ```bash
    cd ability_drive_flutter
    ```
3. Install the dependencies:
    ```bash
    flutter pub get
    ```
4. Run the application:
    ```bash
    flutter run
    ```

## Project Structure
- `lib/`: Contains the main source code for the Flutter application.
  - `main.dart`: Entry point of the application.
  - `models/`: Data models used in the application.
  - `providers/`: State management using Provider.
  - `screens/`: UI screens of the application.
  - `services/`: Services for API interactions.
  - `widgets/`: Reusable UI components.

## Dependencies
The project uses the following dependencies:
- `flutter`: SDK for building Flutter applications.
- `provider`: State management.
- `dio`: For making HTTP requests.
- `url_launcher`: For launching URLs.
- `cupertino_icons`: iOS style icons.
- `ability_drive_api`: API used in the application. [Ability Drive API Repository](https://github.com/Hosny-Mohammed/Ability-Drive-API)

## Code Style
The project follows Dart best practices and uses the `flutter_lints` package for linting. Ensure to run `flutter analyze` before committing code to check for any linting issues.

## Features
- User authentication and registration.
- Ride booking and management.
- Driver profile and ride details.
- State management using Provider.
- Integration with REST APIs using Dio.

## Contributing
We welcome contributions from the community. To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes and push to the branch.
4. Create a pull request with a detailed description of your changes.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

For more information, refer to the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
