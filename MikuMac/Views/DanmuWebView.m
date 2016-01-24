//
//  DaimuWebView.m
//  MikuMac
//
//  Created by heyang on 16/1/19.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "DanmuWebView.h"

@implementation DanmuWebView
- (instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        
        self.drawsBackground = NO;
        
        NSURL *htmlUrl = [NSURL URLWithString:@"http://112.74.93.20:3000"];
        NSURLRequest *request = [NSURLRequest requestWithURL:htmlUrl];
        
        [self.mainFrame loadRequest:request];
    }
    
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}
@end
