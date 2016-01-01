//
// WTKeyboardProtocol.h
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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define SCREEN_SIZE       [UIScreen mainScreen].bounds.size
#define KEYBOARD_HEIGHT   216

typedef NS_ENUM(NSUInteger, WTKeyFunction) {
    WTKeyFunctionInsert = 1,
    WTKeyFunctionDelete,
    WTKeyFunctionNormal,
    WTKeyFunctionReturn,
    WTKeyFunctionUpdate,
    WTKeyFunctionCancel
};

typedef NS_ENUM(NSUInteger, WTKeyboardButtonType) {
    WTKeyboardButtonTypeCharacterKey = 1,
    WTKeyboardButtonTypeFunctionKey
};

typedef NS_ENUM(NSUInteger, WTKeyboardType) {
    WTKeyboardTypeNumPad = 1,
    WTKeyboardTypeCharPad,
    WTKeyboardTypeCardPad,
    WTKeyboardTypeDecimalPad,
    WTKeyboardTypeStockPad
};

@protocol WTKeyboardProtocol <NSObject>

@property (nonatomic, strong) NSArray *characterKeys;
@property (nonatomic, strong) NSArray *functionKeys;
@property (nonatomic, strong) UIButton *crtButton;

- (void)initPad;

- (void)touchBegin:(UIButton *)b type:(WTKeyboardButtonType)type;
- (void)touchMove:(UIButton *)b type:(WTKeyboardButtonType)type;

- (void)touchEnd;
- (WTKeyFunction)touchEnd:(UIButton *)b;
- (WTKeyFunction)touchFunctionEnd:(UIButton *)b;

@end
