import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Grid row movement must not use the geometry of the fixed toolbar.
bool navigateGridRows({
  required int index,
  required int columns,
  required int count,
  required LogicalKeyboardKey key,
  required FocusNode Function(int) nodeAt,
}) {
  int target;
  if (key == LogicalKeyboardKey.arrowUp && index >= columns) {
    target = index - columns;
  } else if (key == LogicalKeyboardKey.arrowDown) {
    if (index ~/ columns == (count - 1) ~/ columns) return true;
    target = min(index + columns, count - 1);
  } else {
    return false;
  }
  final node = nodeAt(target);
  if (node.context != null) node.requestFocus();
  return true;
}
