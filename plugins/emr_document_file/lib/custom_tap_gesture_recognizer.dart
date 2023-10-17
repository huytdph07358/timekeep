import 'package:flutter/gestures.dart';

class CustomTapGestureRecognizer extends OneSequenceGestureRecognizer {
  int? _selectedPointer;

  // Initial Position of selected pointer
  Offset? _initialPos;

  // Timestamp of first pointer (selected) update
  Duration? _first;

  // Timestamp of latest pointer (selected) update
  Duration? _last;

  // Signifies that the event is potentially a tap
  bool _isPotentiallyTap = false;

  // For future taps
  bool _isGoingToFire = false;

  late Function(Offset? initialPos) onTap;

  // Reset everything for a new session
  void _resetState() {
    _isGoingToFire = false;
    _isPotentiallyTap = false;
    _selectedPointer = null;
    _initialPos = null;
    _first = null;
    _last = null;
  }

  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    if (_selectedPointer == null) {
      // Select the first pointer that comes through
      _selectedPointer = event.pointer;
      _isPotentiallyTap = true;
    } else {
      // Multiple pointers on the screen which means it's not a tap
      _selectedPointer = null;
      _isPotentiallyTap = false;
    }

    // Accept all. Rejecting might lead to other gestures not working
    resolve(GestureDisposition.accepted);

    // If previous pointer was going to fire [onTap], stop it.
    // Used to prevent onTap being fired on multi-tap.
    if (_isGoingToFire) {
      _resetState();
    }
  }

  @override
  String get debugDescription => 'only one pointer recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    // onPointerUp, see if it moved and see the duration of its
    // interaction on the screen. If it moved, it's not a tap.
    // If its duration is more than 125 milliseconds (default
    // Android tapTimeout), it's not a tap.
    if (!event.down && event.pointer == _selectedPointer) {
      _last = event.timeStamp;

      if (event.localPosition.distanceSquared ==
              (_initialPos?.distanceSquared ??
                  event.localPosition.distanceSquared) &&
          (_last!.inMilliseconds - _first!.inMilliseconds) <= 125) {
        _isGoingToFire = true;

        // Presenting a slight delay to consider multi-tap case
        Future.delayed(const Duration(milliseconds: 250), () {
          if (_isPotentiallyTap) {
            onTap(_initialPos);
          }
          _resetState();
        });
      } else {
        _resetState();
      }
    } else if (_initialPos == null) {
      // Get initialPos and time
      _initialPos = event.localPosition;
      _first = event.timeStamp;
    }
  }
}
