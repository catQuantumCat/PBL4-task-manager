# Mobile

Installation guide for the mobile application of [todoBK](../../README.md).

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed Flutter SDK. Follow the instructions [here](https://docs.flutter.dev/get-started/install).
- You have a code editor installed, such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
- If VSCode is your IDE, you have installed the [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) and [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) extensions.
  - (Optional) This project uses BLoC as the main state management framework. The [Bloc official plugin](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc) is recommended for working with BLoC.

> [!NOTE]
> This project is developed using Flutter version 3.5.1. Ensure you are using this version or later.

## Installation

To install and run this project, follow these steps:

1. Clone the repository:
   ```sh
   git clone https://github.com/catQuantumCat/PBL4-task-manager/
   ```
2. Navigate to the project directory:
   ```sh
   cd taskmanager
   ```
3. Install the dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run
   ```

## Forked packages

This app, besides utilizing packages on **pub.dev**, also includes a modified version of the [table_calendar 3.12](https://pub.dev/packages/table_calendar) package for the app's specific usage. The modifications can be found in the [table_calendar.dart](#file:table_calendar.dart-context) file.
