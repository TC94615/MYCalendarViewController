//
// Created by 李道政 on 15/5/21.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MYDateCollectionViewCell.h"

@interface MYDateCollectionViewCell()
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation MYDateCollectionViewCell
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *dateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
        }];
        self.dateLabel = dateLabel;


    }
    return self;
}

- (void) updateWithDateComponents:(NSDateComponents *) dateComponents {
    self.dateLabel.text = @(dateComponents.day).stringValue;

}
@end