//
// Created by 李道政 on 15/5/21.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MYDateCollectionViewCell;

@protocol MYCalendarMonthViewControllerDelegate<NSObject>
- (void) tapBackButton:(NSInteger) index;

- (void) tapForwardButton:(NSInteger) index;

- (void) didSelectItem:(MYDateCollectionViewCell *) cell;
@end

@interface MYCalendarMonthViewController : UIViewController
@property (nonatomic, strong) id<MYCalendarMonthViewControllerDelegate> delegate;
@property (nonatomic) NSInteger indexNumber;

- (instancetype) initWithDateComponents:(NSDateComponents *) dateComponents;
@end