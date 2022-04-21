#import "FlutterNumberToWordsEnglishPlugin.h"
#if __has_include(<flutter_number_to_words_english/flutter_number_to_words_english-Swift.h>)
#import <flutter_number_to_words_english/flutter_number_to_words_english-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_number_to_words_english-Swift.h"
#endif

@implementation FlutterNumberToWordsEnglishPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNumberToWordsEnglishPlugin registerWithRegistrar:registrar];
}
@end
