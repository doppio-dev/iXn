export LANG=en_US.UTF-8
cd macos
pod install
cd ..
flutter build macos --release
cd macos
echo $TEST
export FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=$FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD
bundle exec fastlane rel_mac