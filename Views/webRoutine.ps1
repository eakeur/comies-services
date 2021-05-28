flutter build web
Remove-Item '..\comies-services\public\*' -Recurse
Copy-Item -Path '.\build\web\*' -Destination '..\comies-services\public' -Recurse
Write-Host 'Finished web internal deploy. Compiling for Android now'
flutter build windows
flutter build apk --split-per-abi --target-platform android-arm64
Rename-Item '.\build\app\outputs\flutter-apk\app-arm64-v8a-release.apk' -NewName 'arm64.apk'
Move-Item -Path '.\build\app\outputs\flutter-apk\arm64.apk' -Destination '..\comies-services\public'