//
// Created by 李道政 on 15/5/22.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MYCollectionHeaderViewDelegate<NSObject>
- (void) tapBackButton:(UIButton *) sender;

- (void) tapForwardButton:(UIButton *) sender;
@end

@interface MYCollectionHeaderView : UICollectionReusableView
@property (nonatomic, strong) id<MYCollectionHeaderViewDelegate> delegate;

+ (CGFloat) viewHeight;

- (void) updateWithDate:(NSDate *) date;
@end