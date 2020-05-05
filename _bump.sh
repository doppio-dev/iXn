echo '$1 = ' $1
echo '$2 = ' $2
newNumber=$(($2))
echo $newNumber
if  [[ $1 == release/* ]];
then
    echo 'yes'
    newversion=$(echo $1 | sed "s|release\/\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)|\1\.\2\.\3+$newNumber|")
else
    echo 'no'
    version=$(sed -n '18p' pubspec.yaml)
    echo $version
    newversion=$(echo $version | sed "s|version: \([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\+\([0-9]*\)|\1\.\2\.\3+$newNumber|g")
fi
echo 'version: '$newversion
sed -i '' 's|version: .*|version: '$newversion'|' pubspec.yaml
# sed -i '' 's|appVersion = .*|appVersion = \"'$newversion'\";|g' lib/main.dart
echo 'bumped version'
