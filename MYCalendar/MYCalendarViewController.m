//
// Created by 李道政 on 15/5/21.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "MYCalendarViewController.h"
#import "View+MASAdditions.h"
#import "MYDateCollectionViewCell.h"

typedef struct {
    NSUInteger year;
    NSUInteger month;
    NSUInteger day;
} dateFormat;

@interface MYCalendarViewController()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) dateFormat fromDate;
@property (nonatomic, assign) dateFormat toDate;
@property (nonatomic, strong) NSDate *today;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSDate *monthShowing;
@property (nonatomic, strong) NSArray *dateArray;
@end

@implementation MYCalendarViewController

- (void) loadView {
    [super loadView];

    [self commonInitializer];

//    self.title = [self.calendar.calendarIdentifier capitalizedString];



    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewLayout = collectionViewLayout;
    collectionViewLayout.minimumInteritemSpacing = 2.0f;
    collectionViewLayout.minimumLineSpacing = 2.0f;
    collectionViewLayout.itemSize = [self itemSize];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:collectionViewLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.collectionView = collectionView;
    [collectionView registerClass:[MYDateCollectionViewCell class]
       forCellWithReuseIdentifier:MyDateCollectionViewCellReuseIdentifier];
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
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.calendar.locale = [NSLocale currentLocale];
    NSDateComponents *nowYearMonthComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth)
                                                                fromDate:[NSDate date]];
    NSDate *now = [self.calendar dateFromComponents:nowYearMonthComponents];

    self.monthShowing = [NSDate date];
    NSDate *date = [self _firstDayOfMonthContainingDate:self.monthShowing];

    NSDate *endDate = [self _firstDayOfNextMonthContainingDate:self.monthShowing];
    NSMutableArray *dateArray = [@[] mutableCopy];
    while ([date laterDate:endDate] != date) {
        NSLog(@">>>>>>>>>>>> date = %@", date);
        NSDateComponents *todayYearMonthDayComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday)
                                                                         fromDate:date];
        NSLog(@">>>>>>>>>>>> todayYearMonthDayComponents = %@", todayYearMonthDayComponents);
        NSDate *thisDay = [self.calendar dateFromComponents:todayYearMonthDayComponents];
        NSLog(@">>>>>>>>>>>> thisDay = %@", thisDay);
        [dateArray addObject:date];

        date = [self _nextDay:date];
    }
    self.dateArray = [dateArray copy];

    NSDateComponents *todayYearMonthDayComponents = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                                     fromDate:[NSDate date]];
    _today = [self.calendar dateFromComponents:todayYearMonthDayComponents];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(significantTimeChange:)
                                                 name:UIApplicationSignificantTimeChangeNotification
                                               object:nil];
}

- (NSDate *) _firstDay:(NSDate *) date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:date];
    comps.day = 1;
    return [self.calendar dateFromComponents:comps];
}

- (NSDate *) _firstDayOfMonthContainingDate:(NSDate *) date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:date];
    comps.day = 1;
    return [self.calendar dateFromComponents:comps];
}

- (NSDate *) _firstDayOfNextMonthContainingDate:(NSDate *) date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:date];
    comps.day = 1;
    comps.month = comps.month + 1;
    return [self.calendar dateFromComponents:comps];
}

- (NSDate *) _nextDay:(NSDate *) date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

- (dateFormat) pickerDateFromDate:(NSDate *) date {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                    fromDate:date];
    return (dateFormat) {
      components.year,
      components.month,
      components.day
    };
}

#pragma mark UICollectionViewDataSource

- (void) collectionView:(UICollectionView *) collectionView willDisplaySupplementaryView:(UICollectionReusableView *) view forElementKind:(NSString *) elementKind atIndexPath:(NSIndexPath *) indexPath {

}

- (NSInteger) collectionView:(UICollectionView *) collectionView numberOfItemsInSection:(NSInteger) section {
    return self.dateArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *) indexPath {
    MYDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MyDateCollectionViewCellReuseIdentifier
                                                                               forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    NSDate *date = self.dateArray[indexPath.row];
    [cell updateWithDate:date];
    return cell;
}

@end