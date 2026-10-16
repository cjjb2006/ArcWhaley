// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get aboutFlauncher => '关于鲸简 Arc';

  @override
  String get addCategory => '添加分类';

  @override
  String get addSection => '添加分区';

  @override
  String get alphabetical => '按名称';

  @override
  String get appCardHighlightAnimation => '焦点边框动画';

  @override
  String get showFocusBorders => '显示焦点边框';

  @override
  String get appInfo => '应用信息';

  @override
  String get appKeyClick => '按键音效';

  @override
  String get appearanceSettings => '外观';

  @override
  String get backgroundBlur => '背景模糊';

  @override
  String get dockBlur => '底栏模糊';

  @override
  String get dockDarkBackground => '深色底栏';

  @override
  String get dockShadow => '底栏阴影';

  @override
  String get applications => '应用管理';

  @override
  String get autoHideAppBar => '自动隐藏状态栏';

  @override
  String get backButtonAction => '返回键操作';

  @override
  String get category => '分类';

  @override
  String get categories => '分类';

  @override
  String get columnCount => '每行应用数量';

  @override
  String get date => '日期';

  @override
  String get dateAndTimeFormat => '日期和时间格式';

  @override
  String get delete => '删除';

  @override
  String get dialogOptionBackButtonActionDoNothing => '保持桌面';

  @override
  String get dialogOptionBackButtonActionShowScreensaver => '启动屏保';

  @override
  String get dialogOptionBackButtonActionShowClock => '显示时钟';

  @override
  String get dialogTextNoFileExplorer => '请先安装文件管理器。';

  @override
  String get dialogTitleBackButtonAction => '选择返回键操作';

  @override
  String disambiguateCategoryTitle(String title) {
    return '$title（分类）';
  }

  @override
  String formattedDate(String dateString) {
    return '日期预览：$dateString';
  }

  @override
  String formattedTime(String timeString) {
    return '时间预览：$timeString';
  }

  @override
  String get gradient => '渐变';

  @override
  String get favoriteApps => '常用应用';

  @override
  String get grid => '网格';

  @override
  String get height => '高度';

  @override
  String get hide => '隐藏';

  @override
  String get hiddenApplications => '已隐藏应用';

  @override
  String get launcherSections => '桌面分区';

  @override
  String get layout => '布局';

  @override
  String get loading => '正在加载';

  @override
  String get manual => '手动排序';

  @override
  String get modifySection => '编辑分区';

  @override
  String get mustNotBeEmpty => '不能为空';

  @override
  String get name => '名称';

  @override
  String get newSection => '新分区';

  @override
  String get noDateFormatSpecified => '未设置日期格式';

  @override
  String get noTimeFormatSpecified => '未设置时间格式';

  @override
  String get allApplications => '全部应用';

  @override
  String get nonTvApplications => '其他应用';

  @override
  String get open => '打开';

  @override
  String get orSelectFormatSpecifiers => '或选择格式';

  @override
  String get picture => '图片';

  @override
  String removeFrom(String name) {
    return '从$name移除';
  }

  @override
  String get renameCategory => '重命名分类';

  @override
  String get reorder => '调整位置';

  @override
  String get row => '横排';

  @override
  String get rowHeight => '卡片高度';

  @override
  String get save => '保存';

  @override
  String get spacer => '留白';

  @override
  String get spacerMaxHeightRequirement => '请输入 1 到 500 之间的数值';

  @override
  String get statusBar => '状态栏';

  @override
  String get settings => '设置';

  @override
  String get show => '显示';

  @override
  String get showCategoryTitles => '显示分区标题';

  @override
  String get sort => '排序';

  @override
  String get systemSettings => '微鲸系统设置';

  @override
  String get updateCheck => '检查更新';

  @override
  String get updateNoUpdateTitle => '暂无更新';

  @override
  String updateNoUpdateBody(String currentVersion) {
    return '当前版本为 $currentVersion。';
  }

  @override
  String get updateAvailableTitle => '发现新版本';

  @override
  String updateAvailableBody(String latestVersion, String currentVersion) {
    return '新版本 $latestVersion，当前版本 $currentVersion。';
  }

  @override
  String get updateDownloadButton => '下载';

  @override
  String get updateReadyToInstallTitle => '准备安装';

  @override
  String updateReadyToInstallBody(String latestVersion) {
    return '版本 $latestVersion 已下载，是否安装？';
  }

  @override
  String get updateInstallButton => '安装';

  @override
  String get updateInstallPermissionTitle => '需要安装权限';

  @override
  String get updateInstallPermissionBody => '请允许安装应用后重试。';

  @override
  String get updateOpenPermissionSettingsButton => '打开权限设置';

  @override
  String get updateErrorGeneric => '更新失败，请稍后重试。';

  @override
  String textAboutDialog(String repoUrl) {
    return '鲸简 Arc 是基于 Arc Launcher 和 FLauncher 适配微鲸电视的开源桌面。\n\nArc 原作者：Meddouri Badis。\n遵循 GPL-3.0 许可。\n源代码：$repoUrl';
  }

  @override
  String get textEmptyCategory => '此分类暂无应用';

  @override
  String get time => '时间';

  @override
  String get titleStatusBarSettingsPage => '选择状态栏显示内容';

  @override
  String get tvApplications => '电视应用';

  @override
  String get type => '类型';

  @override
  String get typeInTheDateFormat => '输入日期格式';

  @override
  String get typeInTheHourFormat => '输入时间格式';

  @override
  String get uninstall => '卸载';

  @override
  String get wallpaper => '壁纸';

  @override
  String get withEllipsisAddTo => '添加到…';

  @override
  String get timeBasedWallpaper => '定时壁纸';

  @override
  String get pickDayWallpaper => '选择日间壁纸';

  @override
  String get pickNightWallpaper => '选择夜间壁纸';

  @override
  String get video => '视频';

  @override
  String get pickDayVideoWallpaper => '选择日间视频';

  @override
  String get pickNightVideoWallpaper => '选择夜间视频';

  @override
  String get watchNextSectionTitle => '继续观看';

  @override
  String get showWatchNextSection => '显示继续观看';

  @override
  String get watchNextPermissionTitle => '需要观看记录权限';

  @override
  String get watchNextPermissionBody => '允许读取电视观看记录。';

  @override
  String get watchNextGrantPermission => '授权';

  @override
  String get watchNextCheckPermission => '重新检查';

  @override
  String get interface => '桌面界面';

  @override
  String get system => '通用设置';

  @override
  String get accentColor => '强调色';

  @override
  String get miscellaneous => '交互与显示';

  @override
  String get brightnessScheduler => '定时亮度';

  @override
  String get screensaverSettings => '屏保设置';

  @override
  String get screensaverClockStyle => '屏保时钟样式';

  @override
  String get wifiUsagePeriod => '流量统计周期';

  @override
  String get showAppNamesBelowIcons => '在卡片下方显示名称';

  @override
  String get wifiUsage => '网络用量';

  @override
  String get networkIndicator => '网络连接状态';

  @override
  String get customName => '自定义名称';

  @override
  String get lastUsed => '最近使用';

  @override
  String get daily => '每天';

  @override
  String get weekly => '每周';

  @override
  String get monthly => '每月';

  @override
  String get grantPermission => '授权';

  @override
  String get checkStatus => '检查状态';
}
