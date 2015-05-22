//
// Created by 李道政 on 15/5/22.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "UIColor+constant.h"

@implementation UIColor(constant)

+ (UIColor *) hexRGB:(int) rgbHex {
    int r = (rgbHex & 0xFF0000) >> 16;
    int g = (rgbHex & 0x00FF00) >> 8;
    int b = (rgbHex & 0x0000FF);

    return [UIColor colorWithRed:r / (float) 0xFF
                           green:g / (float) 0xFF
                            blue:b / (float) 0xFF
                           alpha:1];
}

+ (UIColor *) backgroundGray {
    return [UIColor hexRGB:0xE6E6E6];
}

+ (UIColor *) backgroundRed {
    return [UIColor hexRGB:0x850038];
}
@end