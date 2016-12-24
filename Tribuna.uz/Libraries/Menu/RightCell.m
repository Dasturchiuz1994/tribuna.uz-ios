//
//  ZCell.m
//  MenuApp
//
//  Created by Jurayev Nodir on 11/11/15.
//  Copyright (c) 2015 Jurayev Nodir. All rights reserved.
//

#import "RightCell.h"

@interface RightCell(){
    
}
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@end



@implementation RightCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _containerView.userInteractionEnabled = YES;
        //self.containerView.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:_containerView];
        
        self.panGesture= [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        self.panGesture.delegate = self;
        self.panGesture.cancelsTouchesInView = YES;
        [self addGestureRecognizer:self.panGesture];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (self.isOpen) {
        CGRect rFrame = self.rightActionView.frame;
        rFrame.size.width = self.rightDefaultWidth;
        rFrame.origin.x = self.frame.size.width - self.rightDefaultWidth;
        [UIView animateWithDuration:0.4 animations:^{
            _containerView.center = CGPointMake(self.frame.size.width/2-self.rightDefaultWidth, self.frame.size.height/2);
            self.rightActionView.frame = rFrame;
            
        }];

    } else{
        [UIView animateWithDuration:0.4 animations:^{
            self.rightActionView.frame = CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height);
            _containerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);;
        }];

    }
}

-(void)setRightActionView:(ActionView *)rightActionView{
    _rightActionView = rightActionView;
    CGRect frame = _rightActionView.frame;
    frame.origin.x = self.frame.size.width;
    _rightActionView.frame =frame;
    [self.contentView addSubview:rightActionView];
}

-(void)pan:(UIPanGestureRecognizer *)recognizer {
    if (!self.rightActionView) {
        return;
    }
    
    if (![recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _containerCenter = _containerView.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self];
        if (_containerCenter.x+translation.x >self.frame.size.width/2) {
            return;
        }
        
        float change = _containerCenter.x + translation.x;
        
        CGRect fr = self.rightActionView.frame;
        fr.size.width = self.frame.size.width/2-change;
        fr.origin.x = self.frame.size.width - fr.size.width;
        
        if (fr.size.width>self.rightDefaultWidth) {
            [self close];
        }
        [UIView animateWithDuration:0.1 animations:^{
            self.rightActionView.frame = fr;
            _containerView.center = CGPointMake(_containerCenter.x + translation.x, _containerCenter.y);
        }];
        
        
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (self.rightActionView.frame.size.width>=self.rightDefaultWidth) {
            [self openRight];
        } else{
            [self closeRight];
        }
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation;
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        translation = [(UILongPressGestureRecognizer*)gestureRecognizer locationInView:_containerView];
    } else if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        translation = [gestureRecognizer translationInView:_containerView];
    }
    
    if (fabsf(translation.x)>fabsf(translation.y)) {
        return YES;
    }
    
    return NO;
}


-(void)close{
    for (RightCell *cell in [self.tableView visibleCells]) {
        if (cell != self && [cell isKindOfClass:[RightCell class]]) {
            [cell reset];
        }
    }
    
}

-(void)reset{
    [UIView animateWithDuration:0.4 animations:^{
        self.rightActionView.frame = CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height);
        _containerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }];
}


-(void)closeRight{
    if (self.openBlock) {
        self.openBlock(-1);
    }
    [self reset];
}

-(void)openRight{
    CGRect rFrame = self.rightActionView.frame;
    rFrame.size.width = self.rightDefaultWidth;
    rFrame.origin.x = self.frame.size.width-self.rightDefaultWidth;
    
    [UIView animateWithDuration: 0.4
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _containerView.center = CGPointMake(self.frame.size.width/2-self.rightDefaultWidth, self.frame.size.height/2);
                         self.rightActionView.frame = rFrame;
                     }
                     completion:^(BOOL finished) {
                     }];
    if (self.openBlock) {
        self.openBlock(self.indexPath.row);
    }

    
}






@end
