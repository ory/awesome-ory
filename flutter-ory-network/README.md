# Integrate Ory Network with Flutter

This example demonstrates how to use Ory Network with a Flutter app. It includes
login and registration with email and password.

## Develop

### Prerequisites

1. [Flutter](https://docs.flutter.dev/get-started/install) version 3.13.1
2. Xcode and Android Studio
3. iOS Simulator or Android Emulator
4. [Ory Network](https://console.ory.sh/) project

### Environmental variables

Create .env file with your project url in the root folder of the Flutter app

```env
ORY_BASE_URL=https://{your-project-slug}.projects.oryapis.com
```

### Google Sign In

If you use Google Sign In on Android, add following variable to .env file

```env
WEB_CLIENT_ID={web-client-id}.apps.googleusercontent.com
```

If you use Google Sign In on iOS, add following variable to .env file

```env

IOS_CLIENT_ID={ios-client-id}.apps.googleusercontent.com
```

Additionally, add iOS URL scheme to Info.plist. It can be found in additional
information of your iOS Client ID.

```xml
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
			<!-- TODO Replace this value with iOS URL scheme from Google Cloud Console -->
				<string>IOS_URL_SCHEME</string>
			</array>
		</dict>
	</array>
```

For more information, see
[Google Integration Docs](https://www.ory.sh/docs/kratos/social-signin/google).

### Apple Sign In

To configure Apple Sign In on IOS, see
[Apple Integration Docs](https://www.ory.sh/docs/kratos/social-signin/apple).\
To configure Apple Sign In on Android, see [Social sign-in for native and mobile apps ](https://www.ory.sh/docs/kratos/social-signin/native-apps).

### Run locally

1. Install dependencies from `pubspec.yaml`

```console
flutter pub get
```

2. open iOS Simulator or Android Emulator
3. Start the app

```console
flutter run
```
