import 'dart:async';

import 'package:flutter/services.dart';

class Readsms {
  /// Event channel used for setting up the stream to receive
  /// sms continously
  static const _channel = EventChannel("readsms");

  final StreamController _controller = StreamController();

  /// The stream containing sms as String
  Stream get smsStream => _controller.stream;

  late final StreamSubscription _channelStreamSubscription;

  /// Listens to the broadcast stream exposed by the event
  /// channel and adds data on the [smsStream] whenever
  /// sms is received
  read() {
    _channelStreamSubscription = _channel.receiveBroadcastStream().listen((e) {
      if (!_controller.isClosed) _controller.sink.add(e);
    });
  }

  /// dispose method.
  void dispose() {
    _controller.close();
    _channelStreamSubscription.cancel();
  }
}
