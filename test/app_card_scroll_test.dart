import 'package:flauncher/models/category.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/widgets/app_card.dart';
import 'package:flauncher/flauncher.dart';
import 'package:flauncher/flauncher_channel.dart';
import 'package:flauncher/models/app.dart';
import 'package:flauncher/providers/launcher_state.dart';
import 'package:flauncher/providers/watch_next_service.dart';
import 'package:flauncher/providers/wallpaper_service.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'whaley_ui_test.dart' show TestApps, localized;

class GridApps extends TestApps {
  late final items = List.generate(24, (i) => App(packageName: 'app$i',
    name: '应用$i', version: '1', hidden: false));
  late final section = Category.withApplications(name: 'All Apps', applications: items, columnsCount: 4);
  @override
  bool get initialized => true;
  @override
  int get layoutVersion => 0;
  @override
  List<Category> get categories => [section];
  @override
  List<LauncherSection> get launcherSections => [section];
}

class StaticWallpaper extends ChangeNotifier implements WallpaperService {
  final ImageProvider image;
  StaticWallpaper(this.image);
  @override
  ImageProvider get wallpaper => image;
  @override
  File? get wallpaperVideoFile => null;
  @override
  int get wallpaperRevision => 0;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('actual launcher scrolls its first grid row back into view', (tester) async {
    SharedPreferences.setMockInitialValues({
      'show_time_in_status_bar': false,
      'show_network_indicator_in_status_bar': false,
    });
    final settings = SettingsService(await SharedPreferences.getInstance());
    final apps = GridApps();
    final image = MemoryImage(await apps.getAppIcon('background'));
    final watchNext = WatchNextService(FLauncherChannel(), enabled: false);
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider<AppsService>.value(value: apps),
      ChangeNotifierProvider<SettingsService>.value(value: settings),
      ChangeNotifierProvider(create: (_) => LauncherState()),
      ChangeNotifierProvider<WallpaperService>(create: (_) => StaticWallpaper(image)),
      ChangeNotifierProvider<WatchNextService>.value(value: watchNext),
    ], child: localized(const FLauncher())));
    await tester.pumpAndSettle();
    for (var i = 0; i < 5; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
    }
    expect(FocusManager.instance.primaryFocus?.debugLabel, 'app20');
    for (var i = 0; i < 5; i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();
    }
    expect(FocusManager.instance.primaryFocus?.debugLabel, 'app0');
    final firstCard = find.byWidgetPredicate((widget) => widget is AppCard && widget.application.packageName == 'app0');
    expect(tester.getTopLeft(firstCard).dy, greaterThanOrEqualTo(kToolbarHeight));
    await tester.pumpWidget(const SizedBox());
    watchNext.dispose();
  });

  testWidgets('returning to a scrolled-off first card reveals it before another up press', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsService(await SharedPreferences.getInstance());
    final apps = TestApps();
    final first = FocusNode();
    final scroll = ScrollController();
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider<AppsService>.value(value: apps),
      ChangeNotifierProvider<SettingsService>.value(value: settings),
    ], child: localized(SingleChildScrollView(controller: scroll, child: Column(children: [
      SizedBox(width: 220, height: 140, child: AppCard(
        key: const ValueKey('first-card'), focusNode: first,
        application: apps.first, category: Category(name: 'All Apps'), autofocus: false,
        onlyScrollWhenNearBottom: true,
        onMove: (_) {}, onMoveEnd: () {},
      )),
      const SizedBox(height: 1500),
    ])))));
    await tester.pumpAndSettle();
    scroll.jumpTo(500);
    await tester.pump();
    expect(tester.getTopLeft(find.byKey(const ValueKey('first-card'))).dy, lessThan(0));
    first.requestFocus();
    await tester.pumpAndSettle();
    expect(first.hasFocus, isTrue);
    expect(scroll.offset, 0);
    expect(tester.getTopLeft(find.byKey(const ValueKey('first-card'))).dy, greaterThanOrEqualTo(0));
    await tester.pumpWidget(const SizedBox());
    first.dispose();
    scroll.dispose();
  });
}
