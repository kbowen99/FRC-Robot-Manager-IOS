rm RobotManager.ipa
cd Robot\ Manager/
xcodebuild
mv build/Release-iphoneos/ build/Payload/
cd build/
zip -r RobotManager.ipa Payload/
cd ..
mv build/RobotManager.ipa RobotManager.ipa
rm -d -f -R build/
cd ..
mv Robot\ Manager/RobotManager.ipa RobotManager.ipa

