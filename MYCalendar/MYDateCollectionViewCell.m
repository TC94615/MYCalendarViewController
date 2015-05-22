//
// Created by 李道政 on 15/5/21.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MYDateCollectionViewCell.h"
#import "UIColor+constant.h"
#import "UIFont+constant.h"
#import "UIDimen.h"

@interface MYDateCollectionViewCell()
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation MYDateCollectionViewCell
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor backgroundLightGray];

        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.textColor = [UIColor textDarkGray];
        dateLabel.font = [UIFont cellFont];
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset([UIDimen generalSpacing]);
            make.top.equalTo(self.contentView).offset([UIDimen generalSpacing]);
        }];
        self.dateLabel = dateLabel;
    }
    return self;
}

- (void) updateWithDateComponents:(NSDateComponents *) dateComponents dayInThisMonth:(BOOL) dayInThisMonth {
    self.dateLabel.text = @(dateComponents.day).stringValue;
    self.dateLabel.textColor = dayInThisMonth ? [UIColor textDarkGray] : [UIColor lightGrayColor];

}
@end