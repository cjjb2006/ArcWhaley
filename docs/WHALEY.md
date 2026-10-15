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
flutter build apk --flavor github --debug --target-platform android-arm64
```
发布版须使用自己的固定签名并开启 v1 签名。不要提交密钥、SDK、APK、电视日志或私人配置。

## 验证边界
测试和 APK 元数据不能证明微鲸实际可安装/流畅。尚需单会话进行安装、启动、方向键、返回原厂 HOME、信号源、待机和投屏验证。当前不接管 HOME、不自动启动、不刷系统或重启电视。

第一版无已验证的微鲸 HDMI 直达接口；通过原厂桌面/遥控器信号源切换。不会猜测输入端口或修改CEC。

本地验证：依赖解析、数据库代码生成、lib 静态分析（无错误；上游提示保留）和9项选定测试通过。首次 Android 打包受本地SDK/NDK许可证与组件缺失限制；由分支专用 CI 继续构建。没有安装到电视。
