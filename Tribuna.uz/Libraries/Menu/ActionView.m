//
//  ActionView.m
//  TestApp
//
//  Created by Jurayev Nodir on 11/10/15.
//  Copyright (c) 2015 Jurayev Nodir. All rights reserved.
//

#import "ActionView.h"

@implementation ActionView

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self changeSubViewsFrame];
}

-(void)changeSubViewsFrame{
    NSArray *items = self.subviews;
    float width = self.frame.size.width/items.count;
    float x = width/2;
    
    for (UIView *view in items) {
        CGRect rect = view.frame;
        rect.size.height = self.frame.size.height;
        rect.size.width = width;
        view.frame = rect;
        CGPoint point = view.center;
        point.x = x;
        view.center = point;
        x+=width;
    }

}

-(instancetype)initWithFrame:(CGRect)frame array:(NSArray *)subViews{
    self = [super initWithFrame:frame];
    
    for (UIView *view in subViews) {
        [self addSubview:view];
    }
    [self changeSubViewsFrame];
    return self;
}
@end
