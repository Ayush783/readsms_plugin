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
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
      "readsms",
      const StandardMethodCodec().encodeSuccessEnvelope(
          ['Flutter', 'Sender798', 1659933434088.toString()]),
      (data) async {
        log('hello');
      },
    );
  });

  tearDown(() {
    plugin.dispose();
  });

  group('read sms plugin tests', () {
    test('instance', () {
      expect(plugin, isA<Readsms>());
    });

    test('expect stream of type SMS', () {
      expect(plugin.smsStream, isA<Stream<SMS>>());
    });

    test('check output', () {
      SMS sms =
          SMS.fromList(['Flutter', 'Sender798', 1659933434088.toString()]);
      final future = plugin.smsStream.first;
      future.then((val) {
        expect(val.body, sms.body);
        expect(val.sender, sms.sender);
        expect(val.timeReceived, sms.timeReceived);
      });
      expect(future, completes);
    });
  });
}
