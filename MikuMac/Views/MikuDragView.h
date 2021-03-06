//
//  MikuDragView.h
//  Miku
//
//  Created by Jobs on 16/1/11.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MikuWebView.h"
#import "DanmuWebView.h"

@interface MikuDragView : NSView

@property (nonatomic, strong) MikuWebView *mikuWebView;
@property (nonatomic, strong) DanmuWebView *danmuWebView;

@end
