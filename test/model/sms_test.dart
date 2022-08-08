import 'package:flutter_test/flutter_test.dart';
import 'package:readsms/model/sms.dart';

void main() {
  SMS sms = SMS(
    body: 'Hello',
    sender: '978865',
    timeReceived: DateTime.fromMillisecondsSinceEpoch(1659933434088),
  );
  group('Tests for SMS model', () {
    test('All attributes of SMS should be non null', () {
      expect(sms.body, isNotNull);
      expect(sms.sender, isNotNull);
      expect(sms.timeReceived, isNotNull);
    });

    test('test fromList method', () {
      final sms2 = SMS.fromList(
        ['Flutter', 'Sender798', 1659933434088.toString()],
      );
      expect(sms2.body, equals('Flutter'));
      expect(sms2.sender, equals('Sender798'));
      expect(sms2.timeReceived,
          DateTime.fromMillisecondsSinceEpoch(1659933434088));
    });
  });
}
