## 0.2.0+4
* Fix #4
* Updated flutter plugin loader to declarative.

## 0.1.0+3
* Migrated to latest Flutter version
* Added RECEIVE_SMS permission to AndroidManifest implicitly
* Removed iOS platform
* Fix #2 Fatal exception when app is terminated
* Updated SDK version constraints

## 0.0.2+2

* Added SMS model
* Now each incoming SMS supports Senders contact and timestamp as well
* Changed stream type of ReadSMS().smsStream to Stream<SMS>
* Updated example/lib/main.dart

## 0.0.1

* This is the first release of readsms plugin for Flutter.
* This plugin currently supports Android
* IoS support to be expected in next release
* More functionalities will be added there after.