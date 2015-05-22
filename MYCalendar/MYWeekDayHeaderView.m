//
// Created by 李道政 on 15/5/22.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "MYWeekDayHeaderView.h"
#import "View+MASAdditions.h"
#import "UIDimen.h"
#import "UIFont+constant.h"
#import "UIColor+constant.h"

static const CGFloat WeekdayViewHeight = 15.0f;

@implementation MYWeekDayHeaderView
+ (CGFloat) viewHeight {
    return WeekdayViewHeight;
}

- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *sundayLabel = [[UILabel alloc] init];
        sundayLabel.text = @"SUN";
        sundayLabel.textColor = [UIColor textDarkGray];
        sundayLabel.font = [UIFont weekdayHeaderFont];
        sundayLabel.textAlignment = NSTextAlignmentCenter;
        sundayLabel.backgroundColor = [UIColor backgroundGray];
        [self addSubview:sundayLabel];
        [sundayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.size.mas_equalTo(self.itemSize);
        }];

        UILabel *mondayLabel = [[UILabel alloc] init];
        mondayLabel.text = @"MON";
        mondayLabel.textColor = [UIColor textDarkGray];
        mondayLabel.font = [UIFont weekdayHeaderFont];
        mondayLabel.textAlignment = NSTextAlignmentCenter;
        mondayLabel.backgroundColor = [UIColor backgroundGray];
        [self addSubview:mondayLabel];
        [mondayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sundayLabel.mas_right).offset([UIDimen generalSpacing]);
            make.top.equalTo(self);
            make.size.mas_equalTo(self.itemSize);
        }];

        UILabel *tuesdayLabel = [[UILabel alloc] init];
        tuesdayLabel.text = @"TUE";
        tuesdayLabel.font = [UIFont weekdayHeaderFont];
        tuesdayLabel.textColor = [UIColor textDarkGray];
        tuesdayLabel.textAlignment = NSTextAlignmentCenter;
        tuesdayLabel.backgroundColor = [UIColor backgroundGray];
        [self addSubview:tuesdayLabel];
        [tuesdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mondayLabel.mas_right).offset([UIDimen generalSpacing]);
            make.top.equalTo(self);
            make.size.mas_equalTo(self.itemSize);
        }];

        UILabel *wednesdayLabel = [[UILabel alloc] init];
        wednesdayLabel.text = @"WED";
        wednesdayLabel.font = [UIFont weekdayHeaderFont];
        wednesdayLabel.textColor = [UIColor textDarkGray];
        wednesdayLabel.textAlignment = NSTextAlignmentCenter;
        wednesdayLabel.backgroundColor = [UIColor backgroundGray];
        [self addSubview:wednesdayLabel];
        [wednesdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tuesdayLabel.mas_right).offset([UIDimen generalSpacing]);
            make.top.equalTo(self);
            make.size.mas_equalTo(self.itemSize);
        }];

        UILabel *thursdayLabel = [[UILabel alloc] init];
        thursdayLabel.text = @"THU";
        thursdayLabel.font = [UIFont weekdayHeaderFont];
        thursdayLabel.textColor = [UIColor textDarkGray];
        thursdayLabel.textAlignment = NSTextAlignmentCenter;
        thursdayLabel.backgroundColor = [UIColor backgroundGray];
        [self addSubview:thursdayLabel];
        [thursdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wednesdayLabel.mas_right).offset([UIDimen generalSpacing]);
            make.top.equalTo(self);
            make.size.mas_equalTo(self.itemSize);
        }];

        UILabel *fridayLabel = [[UILabel alloc] init];
        fridayLabel.text = @"FRI";
        fridayLabel.font = [UIFont weekdayHeaderFont];
        fridayLabel.textColor = [UIColor textDarkGray];
        fridayLabel.textAlignment = NSTextAlignmentCenter;
        fridayLabel.backgroundColor = [UIColor backgroundGray];
        [self addSubview:fridayLabel];
        [fridayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(thursdayLabel.mas_right).offset([UIDimen generalSpacing]);
            make.top.equalTo(self);
            make.size.mas_equalTo(self.itemSize);
        }];

        UILabel *saturdayLabel = [[UILabel alloc] init];
        saturdayLabel.text = @"SAT";
        saturdayLabel.font = [UIFont weekdayHeaderFont];
        saturdayLabel.textColor = [UIColor textDarkGray];
        saturdayLabel.textAlignment = NSTextAlignmentCenter;
        saturdayLabel.backgroundColor = [UIColor backgroundGray];
        [self addSubview:saturdayLabel];
        [saturdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(fridayLabel.mas_right).offset([UIDimen generalSpacing]);
            make.top.equalTo(self);
            make.size.mas_equalTo(self.itemSize);
        }];
    }
    return self;
}

- (CGSize) itemSize {
    NSUInteger numberOfItemsInTheSameRow = 7;
    CGFloat totalInteritemSpacing = [UIDimen generalSpacing] * (numberOfItemsInTheSameRow - 1);
    CGFloat selfItemWidth = (CGRectGetWidth(self.frame) - totalInteritemSpacing) / numberOfItemsInTheSameRow;
    selfItemWidth = (CGFloat) (floor(selfItemWidth * 1000) / 1000);
    CGFloat selfItemHeight = WeekdayViewHeight;
    return (CGSize) {selfItemWidth, selfItemHeight};
}

@end