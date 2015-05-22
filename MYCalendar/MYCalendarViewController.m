//
// Created by 李道政 on 15/5/22.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "MYCalendarViewController.h"
#import "MYCalendarMonthViewController.h"
#import "View+MASAdditions.h"
#import "UIDimen.h"

@interface MYCalendarViewController()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, MYCalendarMonthViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@end

@implementation MYCalendarViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                                 options:@{
                                                                                                   UIPageViewControllerOptionInterPageSpacingKey : @([UIDimen generalSpacing])}];
        pageViewController.delegate = self;
        pageViewController.dataSource = self;

        MYCalendarMonthViewController *monthViewController = [self viewControllerAtIndex:0];
        NSArray *viewControllers = @[monthViewController];
        [pageViewController setViewControllers:viewControllers
                                     direction:UIPageViewControllerNavigationDirectionForward
                                      animated:YES completion:nil];

        [self addChildViewController:pageViewController];
        [self.view addSubview:pageViewController.view];
        [pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
            make.edges.equalTo(self.view).insets(insets);
        }];
        [pageViewController didMoveToParentViewController:self];
        self.pageViewController = pageViewController;
    }
    return self;
}

#pragma mark MYCalendarMonthViewControllerDelegate

- (void) tapBackButton:(NSInteger) index {
    MYCalendarMonthViewController *monthViewController = [self viewControllerAtIndex:index - 1];
    NSArray *viewControllers = @[monthViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES completion:nil];
}

- (void) tapForwardButton:(NSInteger) index {
    MYCalendarMonthViewController *monthViewController = [self viewControllerAtIndex:index + 1];
    NSArray *viewControllers = @[monthViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES completion:nil];
}

- (MYCalendarMonthViewController *) viewControllerAtIndex:(NSInteger) index {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.locale = [NSLocale currentLocale];
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
    dateComponents.month += index;
    MYCalendarMonthViewController *childViewController = [[MYCalendarMonthViewController alloc] initWithDateComponents:dateComponents];
    childViewController.delegate = self;
    childViewController.indexNumber = index;
    return childViewController;
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *) pageViewController:(UIPageViewController *) pageViewController viewControllerBeforeViewController:(UIViewController *) viewController {
    NSInteger index = [(MYCalendarMonthViewController *) viewController indexNumber];
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *) pageViewController:(UIPageViewController *) pageViewController viewControllerAfterViewController:(UIViewController *) viewController {
    NSInteger index = [(MYCalendarMonthViewController *) viewController indexNumber];
    index++;
    return [self viewControllerAtIndex:index];
}

@end