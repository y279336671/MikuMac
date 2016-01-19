//
//  AppDelegate.m
//  MikuMac
//
//  Created by heyang on 16/1/15.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "AppDelegate.h"
#import "MikuDragView.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong)MikuDragView *mikuDragView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
//    tapEvent();

    self.mikuDragView = [[MikuDragView alloc] init];
    
    [self.window setOpaque:NO];
    [self.window setFrame:[NSScreen mainScreen].frame display:YES];
//    [self.window setBackgroundColor:[NSColor clearColor]];
    [self.window setContentView:self.mikuDragView];
//    [self.window setLevel:NSStatusWindowLevel];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

static void tapEvent(){
    CGEventMask eventMask = CGEventMaskBit(kCGEventNull);
    CFMachPortRef eventTap = CGEventTapCreate(kCGHIDEventTap, kCGHeadInsertEventTap,kCGEventTapOptionDefault, eventMask, eventCallback, NULL);
    CFRunLoopSourceRef runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
    CGEventTapEnable(eventTap, true);
    CFRelease(eventTap);
    CFRelease(runLoopSource);
}

static CGEventRef eventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    CGPoint location = CGEventGetLocation(event);
    NSInteger windowNumber = [NSWindow windowNumberAtPoint:location belowWindowWithWindowNumber:0];
    CGWindowID windowID = (CGWindowID)windowNumber;
    
    CFArrayRef array = CFArrayCreate(NULL, (const void **)&windowID, 1, NULL);
    NSArray *windowInfos = (NSArray *)CFBridgingRelease(CGWindowListCreateDescriptionFromArray(array));
    CFRelease(array);
    
    if (windowInfos.count > 0) {
        NSDictionary *windowInfo = [windowInfos objectAtIndex:0];
        NSLog(@"Window name:  %@", [windowInfo objectForKey:(NSString *)kCGWindowName]);
        NSLog(@"Window owner: %@", [windowInfo objectForKey:(NSString *)kCGWindowOwnerName]);
    }
    
    return NULL;
}
@end
