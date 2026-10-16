import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flauncher/providers/settings_service.dart';
import 'package:flauncher/flauncher_channel.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('fresh install avoids GPU blur and media polling UI', () async {
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsService(await SharedPreferences.getInstance());
    expect(settings.backgroundBlurDisabled, isTrue);
    expect(settings.dockBackdropFilterDisabled, isTrue);
    expect(settings.showWatchNextSection, isFalse);
    expect(settings.showWifiWidgetInStatusBar, isFalse);
  });
  test('explicit user appearance choices survive an update', () async {
    SharedPreferences.setMockInitialValues({
      'background_blur_disabled': false,
      'dock_backdrop_filter_disabled': false,
    });
    final settings = SettingsService(await SharedPreferences.getInstance());
    expect(settings.backgroundBlurDisabled, isFalse);
    expect(settings.dockBackdropFilterDisabled, isFalse);
  });
  test('removed media and usage widgets stay disabled after upgrade', () async {
    SharedPreferences.setMockInitialValues({
      'show_watch_next_section': true,
      'show_wifi_widget_in_status_bar': true,
    });
    final settings = SettingsService(await SharedPreferences.getInstance());
    expect(settings.showWatchNextSection, isFalse);
    expect(settings.showWifiWidgetInStatusBar, isFalse);
  });
  test('original home uses dedicated native action and reports failure', () async {
    const channel = MethodChannel('me.efesser.flauncher/method');
    final calls = <MethodCall>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (call) async {calls.add(call);return false;});
    expect(await FLauncherChannel().openOriginalHome(), isFalse);
    expect(calls.single.method, 'openOriginalHome');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, null);
  });
}
