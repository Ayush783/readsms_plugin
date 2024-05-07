import 'dart:async';
export 'model/sms.dart';
import 'package:flutter/services.dart';
import 'package:readsms/model/sms.dart';

class Readsms {
  /// Event channel used for setting up the stream to receive
  /// sms continously
  static const _channel = EventChannel("readsms");

  final StreamController _controller = StreamController<SMS>();

  /// The stream containing sms as [SMS] objects
  Stream<SMS> get smsStream => _controller.stream as Stream<SMS>;

  late final StreamSubscription _channelStreamSubscription;

  /// Listens to the broadcast stream exposed by the event
  /// channel and adds [SMS] on the [smsStream] whenever
  /// sms is received
  read() {
    _channelStreamSubscription = _channel.receiveBroadcastStream().listen((e) {
      if (!_controller.isClosed) {
        _controller.sink.add(SMS.fromList(e));
      }
    });
  }

  /// dispose method.
  void dispose() {
    _controller.close();
    _channelStreamSubscription.cancel();
  }
}
