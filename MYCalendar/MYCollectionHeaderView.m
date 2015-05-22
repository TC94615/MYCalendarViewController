//
// Created by 李道政 on 15/5/22.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MYCollectionHeaderView.h"
#import "UIDimen.h"
#import "MYWeekDayHeaderView.h"
#import "UIColor+constant.h"

static CGFloat const TitleLabelHeight = 20;

@interface MYCollectionHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MYCollectionHeaderView

+ (CGFloat) viewHeight {
    //TODO gap issue
    return TitleLabelHeight + [MYWeekDayHeaderView viewHeight] + 8;
}

- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor backgroundRed];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset([UIDimen standerPadding]);
            make.width.equalTo(self);
            make.height.equalTo(@(TitleLabelHeight));
        }];
        self.titleLabel = titleLabel;

        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton addTarget:self action:@selector(tapBackButton:)
             forControlEvents:UIControlEventTouchUpInside];
        [backButton setImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                    forState:UIControlStateNormal];
        backButton.tintColor = [UIColor whiteColor];
        [self addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset([UIDimen standerPadding]);
            make.centerY.equalTo(titleLabel);
        }];

        UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [forwardButton addTarget:self action:@selector(tapForwardButton:)
                forControlEvents:UIControlEventTouchUpInside];
        [forwardButton setImage:[[UIImage imageNamed:@"forward.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                       forState:UIControlStateNormal];
        forwardButton.tintColor = [UIColor whiteColor];
        [self addSubview:forwardButton];
        [forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-[UIDimen standerPadding]);
            make.centerY.equalTo(titleLabel);
        }];

        MYWeekDayHeaderView *weekDayHeaderView = [[MYWeekDayHeaderView alloc] initWithFrame:frame];
        [self addSubview:weekDayHeaderView];
        [weekDayHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(titleLabel.mas_bottom);
        }];
    }
    return self;
}

- (void) tapBackButton:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(tapBackButton:)]) {
        [self.delegate tapBackButton:nil];
    }
}

- (void) tapForwardButton:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(tapForwardButton:)]) {
        [self.delegate tapForwardButton:nil];
    }
}

- (void) updateWithDateComponents:(NSDateComponents *) components {
    NSString *text = [NSString stringWithFormat:@"%i-%i", components.year, components.month];
    self.titleLabel.text = text;
}
@end