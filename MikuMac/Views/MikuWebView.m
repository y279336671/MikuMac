//
//  MikuWebView.m
//  Miku
//
//  Created by Jobs on 16/1/11.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "MikuWebView.h"

@implementation MikuWebView

- (instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        
        self.drawsBackground = NO;
        
        NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html" inDirectory:@"miku-dancing.coding.io"];

        NSURL *htmlUrl = [NSURL fileURLWithPath:htmlPath];
        NSURLRequest *request = [NSURLRequest requestWithURL:htmlUrl];
        
        [self.mainFrame loadRequest:request];
    }
    
    return self;
}


- (NSView *)hitTest:(NSPoint)aPoint
{
    // http://stackoverflow.com/questions/9073975/cocoa-webview-ignore-mouse-events-in-areas-without-content
    
    return (NSView *)[self nextResponder];
}


- (void)play
{
    [self stringByEvaluatingJavaScriptFromString:@"control.play()"];
}


- (void)pause
{
    [self stringByEvaluatingJavaScriptFromString:@"control.pause()"];
}


- (void)addPlayingTime:(NSInteger)seconds
{
    NSString *script = [NSString stringWithFormat:@"control.addFrame(%li)", seconds];
    [self stringByEvaluatingJavaScriptFromString:script];
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
