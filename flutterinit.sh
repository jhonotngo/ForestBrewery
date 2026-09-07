set -e

echo Cleaning project...
flutter clean 2>&1 >/dev/null
flutter pub get

echo Updating Pod...
pod repo update

echo Generate files...
flutter pub run build_runner build

echo analyze code...
flutter analyze --no-fatal-warnings

echo test
flutter test

echo DONE!

echo run project and follow the instructions to select your emulator
flutter run