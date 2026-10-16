# ArcWhaley — 鲸简 Arc

基于 meddouribadis/arclauncher 的 whaley-api21 分支，目标为微鲸 WTV55K1X、WUI HELIOSR-02.08.03、Android 5.0.2/API21、2GB RAM、蓝牙方向键遥控。

保留 Arc 的 Apple TV 风格卡片与焦点交互。QuietTV 提供保留原厂 HOME 的设计参考；Projectivy 仅作为操作体验参考，未复制其闭源代码或 Apple 商标素材。本项目沿用上游 GPL-3.0 许可及版权声明。

## 第一版实现
- 固定 Flutter3.29.3/Dart3.7，API21 兼容插件版本；独立 applicationId local.whaley.arc。
- 默认深色渐变，关闭实时背景/底栏模糊、Watch Next和流量卡片，保留用户已有外观选择。
- 顶栏房屋按钮：仅在 WTV55K1X 上打开已知微鲸 HOME，不设置默认、不停用原厂桌面。
- 微鲸设置入口优先使用 com.helios.setting，失败回退 Android 标准设置。
- 修复旧 Android 存储权限调用，关闭 API26 以下 Watch Next，保护 API23 流量接口；Java 标准库脱糖兼容旧系统。
- 不改电视背光，关闭上游自动更新查询，避免更新为不能运行的官方新版本。

## 构建
使用 .fvmrc 中的 Flutter3.29.3、JDK17、Android SDK36。
```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test test/whaley_defaults_test.dart test/providers/update_service_test.dart
flutter build apk --flavor github --debug --target-platform android-arm
```
发布版须使用自己的固定签名并开启 v1 签名。不要提交密钥、SDK、APK、电视日志或私人配置。

## 验证边界
测试和 APK 元数据不能证明微鲸实际可安装/流畅。尚需单会话进行安装、启动、方向键、返回原厂 HOME、信号源、待机和投屏验证。当前不接管 HOME、不自动启动、不刷系统或重启电视。

第一版无已验证的微鲸 HDMI 直达接口；通过原厂桌面/遥控器信号源切换。不会猜测输入端口或修改CEC。

本地验证：依赖解析、数据库代码生成、lib 静态分析（无错误；上游提示保留）和9项选定测试通过。

0.1.0 首包在电视启动时崩溃：32 位进程尝试加载 64 位 libflutter.so。APK 架构目录列表不能证明其中所有引擎均已打包。0.1.1 改用 android-arm 和 armeabi-v7a 过滤；CI 逐个读取原生库 ELF 头，验证 ELF32 / EM_ARM，然后验证 Android 5 签名。旧 0.1.0 安装包不应继续使用。修复构建后仍需重新进行电视运行验证。

CI: https://github.com/cjjb2006/ArcWhaley/actions/runs/38714597941

## 0.2.0 中文界面与大卡片
- 固定简体中文，保留原厂应用名称，内置分区显示中文。
- 默认每行 4 张卡片；升级时一次性将超过 4 列的旧分区调整为 4 列，卡片宽度相对 6 列约放大 1.5 倍。之后仍可在分区设置中调整。
- 没有横幅的应用使用固定柔和渐变底板、原图标和较大的名称，不采用实时模糊。
- 网格上下键按行列显式移动，避免跳过前一行到状态栏。
- 应用设置列表按包名保留组件身份，更新包名时刷新图标 Future，避免排序和切换标签后图标串位。
- 移除壁纸、强调色、继续观看、网络用量、原生屏保等不可用入口；关闭对应权限提示和后台统计/观看记录轮询。
- 原生应用扫描移到工作线程，减少首次加载时阻塞界面。首次启动问题仍待实机复测。
- 13 项针对性测试覆盖中文设置、移除入口、旧设置兼容、列表身份、网格上下移动及既有更新逻辑。

## 0.2.1 首行可见性与运行开销
- 修复首行 AppCard 被单独禁用 ensureVisible 的问题；焦点回到首行时也滚动使其可见，取消首行重复的底栏滚动回调。
- 新增完整 FLauncher 布局回归测试，从第六行向上回到首行，检查焦点和实际屏幕位置，而不只检查焦点索引。
- 发布包改用 release/AOT 编译，CI 检查 libapp.so 和非 debuggable；预览签名仍为测试签名，包名仍为 local.whaley.arc.debug。
- 焦点放大由 1.07 改为 1.12，时长 120ms；非选中卡片不绘制动态阴影与淡出遮罩；减少图标解码尺寸及预加载数量。
- 15 项相关测试通过。未实测帧率，不能据此宣称达到原生桌面或 webOS 的流畅度。
