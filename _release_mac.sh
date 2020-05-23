export LANG=en_US.UTF-8
cd macos
pod install
cd ..
flutter build macos --release
cd macos
bundle exec fastlane rel_mac