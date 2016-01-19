//
//  MikuDragView.m
//  Miku
//
//  Created by Jobs on 16/1/11.
//  Copyright © 2016年 Jobs. All rights reserved.
//

#import "MikuDragView.h"

@interface MikuDragView()

@property (nonatomic, assign) NSPoint lastDragLocation;

@end


@implementation MikuDragView

- (instancetype)init
{
    
    if (self = [super initWithFrame:NSMakeRect(0,0,200,300)]) {
        self.mikuWebView = [[MikuWebView alloc] initWithFrame:self.bounds];
        [self addSubview:self.mikuWebView];
        
        self.danmuWebView = [[DanmuWebView alloc]initWithFrame:self.bounds];
        [self addSubview:self.danmuWebView];
        
    }

    return self;
}

-(void)viewDidMoveToWindow{
      NSRect frame = [NSScreen mainScreen].frame;
     [self setFrameOrigin:NSMakePoint(frame.size.width-200, frame.size.height-300)];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    // http://stackoverflow.com/questions/7195835/nsview-dragging-the-view
    
    // Convert to superview's coordinate space
    self.lastDragLocation = [self.superview convertPoint:[theEvent locationInWindow] fromView:nil];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    // 添加负离子防御罩，启用时空拖拽
    // We're working only in the superview's coordinate space, so we always convert.
    NSPoint newDragLocation = [self.superview convertPoint:[theEvent locationInWindow] fromView:nil];
    NSPoint thisOrigin = self.frame.origin;
    thisOrigin.x += (-self.lastDragLocation.x + newDragLocation.x);
    thisOrigin.y += (-self.lastDragLocation.y + newDragLocation.y);
    [self setFrameOrigin:thisOrigin];
    self.lastDragLocation = newDragLocation;
}


- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
    if (hidden) {
        [self.mikuWebView pause];
    } else {
        [self.mikuWebView play];
    }
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
