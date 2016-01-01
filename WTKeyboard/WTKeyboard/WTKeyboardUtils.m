//
// WTKeyboardUtils.h
//
// Copyright (c) 2015 wutongr (http://www.wutongr.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "WTKeyboardUtils.h"
#import <objc/runtime.h>

static NSString *WTKeyboardAccosiationKey = @"WTKeyboardAccosiationKey";

@implementation WTKeyboardUtils

@end

@implementation UITextField (WTKeyboard)

- (void)setWTKeyboardType:(WTKeyboardType)WTKeyboardType{
    NSNumber *UIntegerValue = [NSNumber numberWithUnsignedInteger:WTKeyboardType];
    objc_setAssociatedObject(self, (__bridge const void *)(WTKeyboardAccosiationKey), UIntegerValue, OBJC_ASSOCIATION_COPY);
    
    WTKeyboard *keyboard = [[WTKeyboard alloc]init];
    keyboard.keyboardtype = WTKeyboardType;
    [keyboard setTextView:self];
}

- (WTKeyboardType)WTKeyboardType{
    NSNumber *UIntegerValue = objc_getAssociatedObject(self, (__bridge const void *)(WTKeyboardAccosiationKey));
    return [UIntegerValue unsignedIntegerValue];
}

@end

@implementation NSArray (WTKeyboard)

- (NSEnumerator *)randomObjectEnumerator{
    NSMutableArray *mutable = self.mutableCopy;
    for(int i = 0; i < mutable.count; i++){
        int value = arc4random() % (mutable.count - i) + i;
        [mutable exchangeObjectAtIndex:i withObjectAtIndex:value];
    }
    return [mutable objectEnumerator];
}

@end

@implementation UIColor (WTKeyboard)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end

@implementation UIImage (WTKeyboard)

+ (UIImage *)imageWithHexString:(NSString *)hex{
    UIColor *color = [UIColor colorWithHexString:hex alpha:1.0f];
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
