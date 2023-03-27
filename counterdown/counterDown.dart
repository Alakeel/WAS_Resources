import 'dart:async';
import 'package:intl/intl.dart';

void countdown(String offerCreationTime, int countdownDurationHours) {
  final durationSec = countdownDurationHours * 60 * 60; // convert hours to seconds
  final creationDate = DateTime.parse(offerCreationTime);
  var diffSec = (DateTime.now().millisecondsSinceEpoch - creationDate.millisecondsSinceEpoch) ~/ 1000;
  var remainingSec = durationSec - diffSec;

    if (remainingSec < 0) {
      remainingSec = 0;
    }

    final hours = remainingSec ~/ 3600;
    final minutes = (remainingSec % 3600) ~/ 60;
    final seconds = remainingSec % 60;

    print('${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}');
}

// Example usage: start a 24-hour countdown from the current time
final offerCreationTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(DateTime.now().toUtc());
countdown(offerCreationTime, 24);
