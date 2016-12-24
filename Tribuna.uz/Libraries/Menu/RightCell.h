//
//  ZCell.h
//  MenuApp
//
//  Created by Jurayev Nodir on 11/11/15.
//  Copyright (c) 2015 Jurayev Nodir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionView.h"

@interface RightCell : UITableViewCell{

    float _startX;
    float _startY;
    BOOL _isRight;
    CGPoint _containerCenter;
    CGPoint _rCenter;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *containerView;

@property (nonatomic, strong) ActionView *rightActionView;
@property (nonatomic, assign) float rightDefaultWidth;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) void(^openBlock)(NSInteger index);



- (void) reset;

@end
