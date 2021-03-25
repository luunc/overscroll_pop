#import "OverscrollPopPlugin.h"
#if __has_include(<overscroll_pop/overscroll_pop-Swift.h>)
#import <overscroll_pop/overscroll_pop-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "overscroll_pop-Swift.h"
#endif

@implementation OverscrollPopPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOverscrollPopPlugin registerWithRegistrar:registrar];
}
@end
