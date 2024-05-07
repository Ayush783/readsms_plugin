# readsms

This is a plugin made for flutter to read incoming sms on the device as a broadcast stream.

Following steps describe how to use the plugin ReadSms :- 

* Ask the user for Sms permission. You can do this using <a href="https://pub.dev/packages/permission_handler">Permission handler</a> package.
* Create an instance of ReadSms.
```dart
  final plugin = ReadSms();
```
* Call the read method on the plugin object;
```dart
  plugin.read();
``` 
* Access the stream of SMS exposed by the plugin object and get the incoming SMS.
```dart
  plugin.smsStream.listen((sms){
    print(sms.body);
    print(sms.sender);
    print(sms.timeReceived);
  });
```

That's all you need to do.
