//
// WTKeyboardNumPad.m
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

#import "WTKeyboardNumPad.h"
#import "WTKeyboardUtils.h"

#define kNums   @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]
#define kFuncs  @[@"取消",@"确定",@"退格"]

@implementation WTKeyboardNumPad
@synthesize characterKeys,functionKeys,crtButton;

- (void)initPad{
    NSMutableArray *keys = [kNums randomObjectEnumerator].allObjects.mutableCopy;
    [keys addObject:@"0"];
    [keys addObjectsFromArray:kFuncs];
    
    NSMutableArray *btns = [NSMutableArray array];
    NSMutableArray *funcBtns = [NSMutableArray array];
    
    [keys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int asciiCode = [obj characterAtIndex:0];
        UIButton *btn = [[UIButton alloc]init];
        [btn setUserInteractionEnabled:NO];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithHexString:@"d2d5db"] forState:UIControlStateSelected];
        
        if(asciiCode >= 49 && asciiCode <= 57){
            [btn setFrame:CGRectMake(idx % 3 * (SCREEN_SIZE.width / 4), idx / 3 * (KEYBOARD_HEIGHT / 4), SCREEN_SIZE.width / 4 - 0.5, KEYBOARD_HEIGHT / 4 - 0.5)];
            [btns addObject:btn];
        }else if (asciiCode == 48){
            [btn setFrame:CGRectMake(SCREEN_SIZE.width / 4, KEYBOARD_HEIGHT / 4 * 3, SCREEN_SIZE.width / 4 - 0.5, KEYBOARD_HEIGHT / 4 - 0.5)];
            [btns addObject:btn];
        }else{
            if([obj isEqualToString:@"取消"]){
                [btn setImage:[UIImage imageNamed:@"keyboard_stock_cancel.png"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"keyboard_stock_cancel.png"] forState:UIControlStateSelected];
                [btn setFrame:CGRectMake(SCREEN_SIZE.width / 4 * 3, 0, SCREEN_SIZE.width / 4, KEYBOARD_HEIGHT / 4)];
            }else if ([obj isEqualToString:@"退格"]){
                [btn setFrame:CGRectMake(SCREEN_SIZE.width / 4 * 3, KEYBOARD_HEIGHT / 4, SCREEN_SIZE.width / 4, KEYBOARD_HEIGHT / 2 - 0.5)];
                [btn setBackgroundImage:[UIImage imageWithHexString:@"5aafe3"] forState:UIControlStateNormal];
            }else if ([obj isEqualToString:@"确定"]){
                [btn setFrame:CGRectMake(SCREEN_SIZE.width / 2, KEYBOARD_HEIGHT / 4 * 3, SCREEN_SIZE.width / 2, KEYBOARD_HEIGHT / 4)];
                [btn setBackgroundImage:[UIImage imageWithHexString:@"5aafe3"] forState:UIControlStateNormal];
            }
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [funcBtns addObject:btn];
        }
    }];
    
    self.characterKeys = btns;
    self.functionKeys = funcBtns;
}

- (void)touchBegin:(UIButton *)b type:(WTKeyboardButtonType)type{
    b.selected = YES;
    self.crtButton = b;
}

- (void)touchMove:(UIButton *)b type:(WTKeyboardButtonType)type{
    b.selected = YES;
    if(self.crtButton != b){
        self.crtButton.selected = NO;
        self.crtButton = b;
    }
}

- (void)touchEnd{
    for(UIButton *btn in self.characterKeys) btn.selected = NO;
    for(UIButton *btn in self.functionKeys) btn.selected = NO;
}

- (WTKeyFunction)touchEnd:(UIButton *)b{
    b.selected = NO;
    if(!b.titleLabel.text) return WTKeyFunctionCustom;
    return WTKeyFunctionInsert;
}

- (WTKeyFunction)touchFunctionEnd:(UIButton *)b{
    b.selected = NO;
    if([b.titleLabel.text isEqualToString:@"取消"]){
        return WTKeyFunctionCancel;
    }else if ([b.titleLabel.text isEqualToString:@"退格"]){
        return WTKeyFunctionDelete;
    }else if([b.titleLabel.text isEqualToString:@"确定"]){
        return WTKeyFunctionReturn;
    }
    return WTKeyFunctionNormal;
}

@end
