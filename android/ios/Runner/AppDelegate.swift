import Flutter
import UIKit
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register the WorkManager task
    WorkmanagerPlugin.registerTask(withIdentifier: "refreshTokenTask")

    // Ensure the Flutter plugin registrants are loaded
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
