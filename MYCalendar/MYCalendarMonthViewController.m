//
// Created by 李道政 on 15/5/21.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "MYCalendarMonthViewController.h"
#import "View+MASAdditions.h"
#import "MYDateCollectionViewCell.h"
#import "MYCollectionHeaderView.h"
#import "UIDimen.h"

static NSString *const HeaderIdentifier = @"HeaderIdentifier";

static const NSUInteger MaxDaysCount = 42;

@interface MYCalendarMonthViewController()<UICollectionViewDelegate, UICollectionViewDataSource, MYCollectionHeaderViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *today;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSDate *monthShowing;
@property (nonatomic, strong) NSArray *dateArray;
@end

@implementation MYCalendarMonthViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        _calendar.locale = [NSLocale currentLocale];
        _monthShowing = [NSDate date];
    }
    return self;
}

- (instancetype) initWithDateComponents:(NSDateComponents *) dateComponents {
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        _calendar.locale = [NSLocale currentLocale];
        _monthShowing = [_calendar dateFromComponents:dateComponents];
    }
    return self;
}

- (void) loadView {
    [super loadView];

    [self commonInitializer];
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewLayout = collectionViewLayout;
    collectionViewLayout.minimumInteritemSpacing = [UIDimen generalSpacing];
    collectionViewLayout.minimumLineSpacing = [UIDimen generalSpacing];
    collectionViewLayout.itemSize = [self itemSize];
    [collectionViewLayout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, [MYCollectionHeaderView viewHeight])];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:collectionViewLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.collectionView = collectionView;
    [collectionView registerClass:[MYDateCollectionViewCell class]
       forCellWithReuseIdentifier:MyDateCollectionViewCellReuseIdentifier];
    [collectionView registerClass:[MYCollectionHeaderView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:HeaderIdentifier];

}

- (void) viewDidLoad {
    [super viewDidLoad];

    [self.collectionView reloadData];
}

- (CGSize) itemSize {
    NSUInteger numberOfItemsInTheSameRow = 7;
    CGFloat totalInteritemSpacing = self.collectionViewLayout.minimumInteritemSpacing * (numberOfItemsInTheSameRow - 1);
    CGFloat selfItemWidth = (CGRectGetWidth(self.view.frame) - totalInteritemSpacing) / numberOfItemsInTheSameRow;
    selfItemWidth = (CGFloat) (floor(selfItemWidth * 1000) / 1000);
    CGFloat selfItemHeight = 70.0f;
    return (CGSize) {selfItemWidth, selfItemHeight};
}

- (void) commonInitializer {

    NSDate *beginDate = [self firstDay:self.monthShowing];
    NSDate *endDate = [self lastDay:self.monthShowing];
    NSDateComponents *components = [self.calendar components:NSDayCalendarUnit fromDate:beginDate
                                                      toDate:endDate options:nil];
    if (components.day < MaxDaysCount) {
        endDate = [self addAWeekToDate:endDate];
    }
    NSMutableArray *dateArray = [@[] mutableCopy];
    while ([beginDate laterDate:endDate] != beginDate) {
        [dateArray addObject:beginDate];
        beginDate = [self _nextDay:beginDate];
    }
    self.dateArray = [dateArray copy];
}

- (NSDate *) firstDay:(NSDate *) date {
    NSDateComponents *thisDateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                            fromDate:date];
    thisDateComponents.day = 1;
    NSDate *firstDateInThisMonth = [self.calendar dateFromComponents:thisDateComponents];
    NSDateComponents *firstDateComponentsInThisMonth =
      [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit)
                       fromDate:firstDateInThisMonth];
    switch (firstDateComponentsInThisMonth.weekday) {
        case 1:
            [firstDateComponentsInThisMonth setDay:firstDateComponentsInThisMonth.day - 7];
            break;
        case 2:
            [firstDateComponentsInThisMonth setDay:firstDateComponentsInThisMonth.day - 1];
            break;
        case 3:
            [firstDateComponentsInThisMonth setDay:firstDateComponentsInThisMonth.day - 2];
            break;
        case 4:
            [firstDateComponentsInThisMonth setDay:firstDateComponentsInThisMonth.day - 3];
            break;
        case 5:
            [firstDateComponentsInThisMonth setDay:firstDateComponentsInThisMonth.day - 4];
            break;
        case 6:
            [firstDateComponentsInThisMonth setDay:firstDateComponentsInThisMonth.day - 5];
            break;
        case 7:
            [firstDateComponentsInThisMonth setDay:firstDateComponentsInThisMonth.day - 6];
            break;
        default:
            break;
    }
    return [self.calendar dateFromComponents:firstDateComponentsInThisMonth];
}

- (NSDate *) lastDay:(NSDate *) date {
    NSDateComponents *thisDateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                            fromDate:date];
    thisDateComponents.day = 0;
    thisDateComponents.month = thisDateComponents.month + 1;
    NSDate *lastDateInThisMonth = [self.calendar dateFromComponents:thisDateComponents];
    NSDateComponents *lastDateComponentsInThisMonth =
      [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit)
                       fromDate:lastDateInThisMonth];
    switch (lastDateComponentsInThisMonth.weekday) {
        case 1:
            [lastDateComponentsInThisMonth setDay:lastDateComponentsInThisMonth.day + 7];
            break;
        case 2:
            [lastDateComponentsInThisMonth setDay:lastDateComponentsInThisMonth.day + 6];
            break;
        case 3:
            [lastDateComponentsInThisMonth setDay:lastDateComponentsInThisMonth.day + 5];
            break;
        case 4:
            [lastDateComponentsInThisMonth setDay:lastDateComponentsInThisMonth.day + 4];
            break;
        case 5:
            [lastDateComponentsInThisMonth setDay:lastDateComponentsInThisMonth.day + 3];
            break;
        case 6:
            [lastDateComponentsInThisMonth setDay:lastDateComponentsInThisMonth.day + 2];
            break;
        case 7:
            [lastDateComponentsInThisMonth setDay:lastDateComponentsInThisMonth.day + 1];
            break;
        default:
            break;
    }
    return [self.calendar dateFromComponents:lastDateComponentsInThisMonth];
}

- (NSDate *) addAWeekToDate:(NSDate *) date {
    NSDateComponents *thisDateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                            fromDate:date];
    thisDateComponents.day += 7;
    return [self.calendar dateFromComponents:thisDateComponents];
}

- (NSDate *) _nextDay:(NSDate *) date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

#pragma mark UICollectionViewDataSource

- (UICollectionReusableView *) collectionView:(UICollectionView *) collectionView viewForSupplementaryElementOfKind:(NSString *) kind atIndexPath:(NSIndexPath *) indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MYCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                withReuseIdentifier:HeaderIdentifier
                                                                                       forIndexPath:indexPath];
        headerView.delegate = self;
        [headerView updateWithDate:self.monthShowing];
        return headerView;
    }
    return nil;
}

- (NSInteger) collectionView:(UICollectionView *) collectionView numberOfItemsInSection:(NSInteger) section {
    return self.dateArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *) indexPath {
    MYDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MyDateCollectionViewCellReuseIdentifier
                                                                               forIndexPath:indexPath];
    NSDate *date = self.dateArray[indexPath.row];
    NSDateComponents *dateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit)
                                                        fromDate:date];
    NSInteger thisMonth = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit
                                                          fromDate:self.monthShowing].month;
    [cell updateWithDateComponents:dateComponents dayInThisMonth:dateComponents.month == thisMonth];
    if ([self.delegate respondsToSelector:@selector(calendarCell:forDate:)]) {
        [self.delegate calendarCell:cell forDate:date];
    }
    return cell;
}

- (void) collectionView:(UICollectionView *) collectionView didSelectItemAtIndexPath:(NSIndexPath *) indexPath {
    MYDateCollectionViewCell *cell = (MYDateCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(didSelectCell:)]) {
        [self.delegate didSelectCell:cell];
    }
}

#pragma mark MYCollectionHeaderViewDelegate

- (void) tapBackButton:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(tapBackButton:)]) {
        [self.delegate tapBackButton:self.indexNumber];
    }
}

- (void) tapForwardButton:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(tapForwardButton:)]) {
        [self.delegate tapForwardButton:self.indexNumber];
    }
}

@end