//
// Created by 李道政 on 15/5/21.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const MyDateCollectionViewCellReuseIdentifier = @"MyDateCollectionViewCellReuseIdentifier";

@interface MYDateCollectionViewCell : UICollectionViewCell

- (void) updateWithDateComponents:(NSDateComponents *) dateComponents;
@end