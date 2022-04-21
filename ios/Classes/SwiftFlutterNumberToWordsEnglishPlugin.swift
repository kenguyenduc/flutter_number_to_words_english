import Flutter
import UIKit

public class SwiftFlutterNumberToWordsEnglishPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_number_to_words_english", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterNumberToWordsEnglishPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
