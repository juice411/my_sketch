import 'package:flutter/foundation.dart';

enum Controls { sketch, canvas }

class ControlsNotifier extends ValueNotifier<Controls> {
  ControlsNotifier(Controls value) : super(value);
}