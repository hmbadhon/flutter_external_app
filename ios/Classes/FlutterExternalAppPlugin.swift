import Flutter
import UIKit

public class FlutterExternalAppPlugin: NSObject, FlutterPlugin{
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "me.hmbadhon.flutter_external_app", binaryMessenger: registrar.messenger())
        let instance = FlutterExternalAppPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "sendToExternalAppIOS" {
            if let link = call.arguments as? String {
                openExternalApp(with: link)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid link argument", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func openExternalApp(with link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                if success {
                    print("External app opened successfully.")
                } else {
                    print("Failed to open external app.")
                }
            })
        }
    }
}
