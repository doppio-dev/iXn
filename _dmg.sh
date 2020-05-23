# test -f doppio_dev_site.dmg && rm doppio_dev_site.dmg
mkdir "release/macos/dmg"
echo "Start create-dmg"
# https://github.com/sindresorhus/create-dmg
create-dmg  'release/macos/iXn.app' 'release/macos/dmg'
echo "Finish create-dmg"
