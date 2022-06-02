import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readsms/readsms.dart';

void main() {
  // const channel = MethodChannel("readsms");
  TestWidgetsFlutterBinding.ensureInitialized();
  late final Readsms plugin;
  setUpAll(() {
    plugin = Readsms()..read();
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
        .handlePlatformMessage(
      "readsms",
      const StandardMethodCodec().encodeSuccessEnvelope('Flutter'),
      (data) async {
        log('hello');
      },
    );
  });

  tearDown(() {
    // plugin.dispose();
  });

  group('read sms plugin tests', () {
    test('instance', () {
      expect(plugin, isA<Readsms>());
    });

    test('check output', () {
      expect(
        plugin.smsStream.first,
        completion(
          equals('Flutter'),
        ),
      );
    });
  });
}
