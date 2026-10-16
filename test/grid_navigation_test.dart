import 'package:flauncher/grid_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('up from the final partial grid row visits each previous row', (tester) async {
    final nodes = List.generate(10, (_) => FocusNode());
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Column(children: [
      const TextButton(onPressed: null, child: Text('状态栏')),
      Expanded(child: GridView.count(crossAxisCount: 4, children: List.generate(10, (index) =>
        Focus(focusNode: nodes[index], onKeyEvent: (_, event) {
          if (event is! KeyDownEvent) return KeyEventResult.ignored;
          return navigateGridRows(index: index, columns: 4, count: 10,
            key: event.logicalKey, nodeAt: (target) => nodes[target])
              ? KeyEventResult.handled : KeyEventResult.ignored;
        }, child: Text('$index')))),),
    ]))));
    nodes[9].requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
    await tester.pump();
    expect(nodes[5].hasPrimaryFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
    await tester.pump();
    expect(nodes[1].hasPrimaryFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    expect(nodes[9].hasPrimaryFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    expect(nodes[9].hasPrimaryFocus, isTrue);
    await tester.pumpWidget(const SizedBox());
    for (final node in nodes) { node.dispose(); }
  });
}
