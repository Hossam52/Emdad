import UIKit
import Flutter
import GoogleMaps  // Add this import For google maps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
   //Google maps integrations
    GMSServices.provideAPIKey("AIzaSyD0fPlDTXQ3ne6LpBSoIEMSq5i3vAEmIWU")
    //End google maps integrationsw
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
