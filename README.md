![mobileQmsPro banner](https://wheref.com/assets/mobileqmspro/images/mobileqmspro.png)

# MobileQMSPro PROJECT
* MobileApp Based Queue Management Solution built with Flutter and Serverpod.dev for single queue line and single counter
* MobileQMSPro aim to reduce physical congestion, improve efficiency, and enhance customer satisfaction by providing a more convenient and flexible way for users to wait for service. They are particularly useful in settings such as retail stores, healthcare facilities, government offices, and theme parks where long queues are common
* This system typically utilizes software applications or platforms to facilitate the queueing process

## Running the server
To run the server locally:

```bash
cd mobileqmspro_server
dart bin/main.dart
```

## Setup database
Create password.yaml inside the config folder

## Running the app
To start the app:

```bash
cd mobileqmspro_flutter
flutter run
```

# USEFUL COMMAND
```bash
$ dart pub global activate serverpod_cli
$ serverpod generate
$ serverpod create-migration
$ dart bin/main.dart --apply-migrations -r maintenance
$ dart bin/main.dart
$ dart run intl_utils:generate
$ flutter run -d chrome --web-port=1234
$ flutter create .
$ dart compile aot-snapshot bin/main.dart 
$ dartaotruntime bin/main.aot
```

## Download App
* AppStore: https://apps.apple.com/us/app/mobileqmspro/id6738298234

## License
All MobileQMSPro packages are licensed under BSD-3, except for the main `mobileqmspro` package, which uses the SSPL license. In short, this means that you can, without limitation, use any of the client packages in your app. You can also host your MobileQMSPro server without limitation as long as you do not offer mobileqmspro as a cloud service to 3rd parties (this is typically only relevant for cloud service providers).