import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flauncher/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flauncher/models/app.dart';
import 'package:flauncher/models/category.dart';
import 'package:flauncher/providers/apps_service.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/widgets/settings/applications_panel_page.dart';
import 'package:flauncher/widgets/settings/interface_settings_page.dart';
import 'package:flauncher/widgets/settings/status_bar_panel_page.dart';
import 'package:flauncher/widgets/settings/misc_panel_page.dart';

class TestApps extends ChangeNotifier implements AppsService {
  final first = App(packageName: 'first', name: '应用甲', version: '1', hidden: false);
  final second = App(packageName: 'second', name: '应用乙', version: '1', hidden: false);
  final requested = <String>[];
  bool reversed = false;
  @override
  String? get pendingReorderFocusPackage => null;
  @override
  int? get pendingReorderFocusCategoryId => null;
  @override
  bool consumeDirtyImage(String packageName) => false;
  @override
  Future<Uint8List> getAppBanner(String packageName) async => Uint8List(0);
  @override
  List<App> get applications => reversed ? [second, first] : [first, second];
  @override
  List<Category> get categories => [Category.withApplications(name: 'Favorites', applications: [second])];
  @override
  Future<Uint8List> getAppIcon(String name) async {
    requested.add(name);
    return base64Decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQIHWP4z8DwHwAFgAI/ScLbtAAAAABJRU5ErkJggg==');
  }
  void reorder() { reversed = true; notifyListeners(); }
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget localized(Widget child) => MaterialApp(
  locale: const Locale('zh'), supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate],
  home: Scaffold(body: child),
);

void main() {
  testWidgets('Chinese settings omit wallpaper accent and unsupported media controls', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsService(await SharedPreferences.getInstance());
    Future<void> show(Widget page) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(value: settings, child: localized(page)));
      await tester.pumpAndSettle();
    }
    await show(const InterfaceSettingsPage());
    expect(find.text('桌面界面'), findsOneWidget);
    expect(find.text('壁纸'), findsNothing);
    expect(find.text('强调色'), findsNothing);
    await show(StatusBarPanelPage());
    expect(find.text('网络用量'), findsNothing);
    expect(find.text('网络连接状态'), findsOneWidget);
    await show(const MiscPanelPage());
    expect(find.text('显示继续观看'), findsNothing);
  });

  testWidgets('app list identity follows package through reordering and tab changes', (tester) async {
    final apps = TestApps();
    await tester.pumpWidget(ChangeNotifierProvider<AppsService>.value(
      value: apps, child: localized(const ApplicationsPanelPage())));
    await tester.pumpAndSettle();
    expect(apps.requested, containsAll(['first', 'second']));
    apps.requested.clear();
    apps.reorder();
    await tester.pumpAndSettle();
    final tiles = tester.widgetList<ListTile>(find.byType(ListTile)).toList();
    expect((tiles[0].title as Text).data, '应用乙');
    expect((tiles[1].title as Text).data, '应用甲');
    // Existing item state must move with its package, not reload a different icon by position.
    expect(apps.requested, isEmpty);
    await tester.tap(find.byIcon(Icons.star));
    await tester.pumpAndSettle();
    expect(find.text('应用甲'), findsNothing);
    expect(find.text('应用乙'), findsOneWidget);
  });
}
