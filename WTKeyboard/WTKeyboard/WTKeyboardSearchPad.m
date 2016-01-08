//
// WTKeyboardSearchPad.m
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

#import "WTKeyboardSearchPad.h"

#define kNums   @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"00",@"000",@"300",@"600"]
#define kFuncs1 @[@"取消",@"上证",@"深证",@"ABC",@"退格",@"搜索"]
#define kChars  @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",    \
                  @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",         \
                  @"Z",@"X",@"C",@"V",@"B",@"N",@"M"]
#define kFuncs2 @[@"取消",@"退格",@"123",@"   ",@"搜索"]

#define kNSideGap 4
#define kNMidGap  3
#define kCWSideGap 2
#define kCWMinGap 3
#define kCHSideGap 5
#define kCHMinGap 15

@interface WTKeyboardSearchPad ()

@property (nonatomic, assign, getter=isCharPad) BOOL charPad;

@end

@implementation WTKeyboardSearchPad
@synthesize characterKeys,functionKeys,crtButton;

- (void)initPad{
    NSMutableArray * __block btns = [NSMutableArray array];
    NSMutableArray * __block funcbtns = [NSMutableArray array];
    
    //两种布局都生成
    //第一页数字
    [kNums enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int asciiCode = [obj characterAtIndex:0];
        UIButton *btn = [[UIButton alloc]init];
        [btn setUserInteractionEnabled:NO];
//        [btn setHidden:YES];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W110H96.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W170H96.png"] forState:UIControlStateSelected];
        [btns addObject:btn];
        if(obj.length <= 2 || asciiCode == 48){
            [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5 + kNMidGap) * ((idx % 3) + 1) + kNSideGap, ((KEYBOARD_HEIGHT - kNMidGap * 5) / 4 + kNMidGap) * (idx / 3) + kNMidGap, (SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5, (KEYBOARD_HEIGHT - kNMidGap * 5) / 4)];
        }else if (obj.length == 3){
            if (asciiCode == 51){
                [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5 + kNMidGap) * 4 + kNSideGap, ((KEYBOARD_HEIGHT - kNMidGap * 5) / 4 + kNMidGap) * 1 + kNMidGap, (SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5, (KEYBOARD_HEIGHT - kNMidGap * 5) / 4)];
            }else if (asciiCode == 54){
                [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5 + kNMidGap) * 4 + kNSideGap, ((KEYBOARD_HEIGHT - kNMidGap * 5) / 4 + kNMidGap) * 2 + kNMidGap, (SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5, (KEYBOARD_HEIGHT - kNMidGap * 5) / 4)];
            }
        }
    }];
    
    [kFuncs1 enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setUserInteractionEnabled:NO];
//        [btn setHidden:YES];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateSelected];
        [funcbtns addObject:btn];
        if(idx <= 2){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W110H96.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W170H96.png"] forState:UIControlStateSelected];
            [btn setFrame:CGRectMake(kNSideGap, ((KEYBOARD_HEIGHT - kNMidGap * 5) / 4 + kNMidGap) * idx + kNMidGap, (SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5, (KEYBOARD_HEIGHT - kNMidGap * 5) / 4)];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W110H96.png"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W170H96.png"] forState:UIControlStateNormal];
            if (idx == 3){
                [btn setFrame:CGRectMake(kNSideGap, ((KEYBOARD_HEIGHT - kNMidGap * 5) / 4 + kNMidGap) * idx + kNMidGap, (SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5, (KEYBOARD_HEIGHT - kNMidGap * 5) / 4)];
            }else if (idx == 4){
                [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5 + kNMidGap) * 4 + kNSideGap, kNMidGap, (SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5, (KEYBOARD_HEIGHT - kNMidGap * 5) / 4)];
            }else if (idx == 5){
                [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5 + kNMidGap) * 4 + kNSideGap, ((KEYBOARD_HEIGHT - kNMidGap * 5) / 4 + kNMidGap) * 3 + kNMidGap, (SCREEN_SIZE.width - kNMidGap * 4 - kNSideGap * 2) / 5, (KEYBOARD_HEIGHT - kNMidGap * 5) / 4)];
            }
        }
    }];
    //第二页字母(隐藏)
    [kChars enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setUserInteractionEnabled:NO];
        [btn setHidden:YES];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W56H82.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W96H82.png"] forState:UIControlStateSelected];
        [btns addObject:btn];
        if(idx < 10){
            [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 + kCWMinGap) * (idx % 10) + kCWSideGap, kCHSideGap, (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }else if (idx < 19){
            [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 + kCWMinGap) * (idx % 10) + kCWSideGap + ((SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 + kCWMinGap) / 2, ((KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4 + kCHMinGap) * 1 + kCHSideGap, (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }else{
            [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 + kCWMinGap) * (idx % 19) + kCWSideGap + ((SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 + kCWMinGap) / 2 * 3, ((KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4 + kCHMinGap) * 2 + kCHSideGap, (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }
    }];
    
    [kFuncs2 enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setHidden:YES];
        [btn setUserInteractionEnabled:NO];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateSelected];
        [funcbtns addObject:btn];
        if(idx == 0){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W110H96.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W170H96.png"] forState:UIControlStateSelected];
            [btn setFrame:CGRectMake(kCWSideGap, ((KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4 + kCHMinGap) * 2 + kCHSideGap, kCWSideGap + (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 / 2 * 3, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }else if (idx == 1){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W110H96.png"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W170H96.png"] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(((SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 + kCWMinGap) * 8 + kCWSideGap + ((SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 + kCWMinGap) / 2, ((KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4 + kCHMinGap) * 2 + kCHSideGap, kCWSideGap + (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 / 2 * 3, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }else if (idx == 2){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W184H72.png"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W260H72.png"] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(kCWSideGap, ((KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4 + kCHMinGap) * 3 + kCHSideGap, kCWSideGap + (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 / 2 * 5, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }else if (idx == 3){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W420H80.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W520H80.png"] forState:UIControlStateSelected];
            [btn setFrame:CGRectMake(kCWSideGap + kCWMinGap + (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 / 2 * 5 + kCWMinGap, ((KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4 + kCHMinGap) * 3 + kCHSideGap, SCREEN_SIZE.width - (kCWSideGap + (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 / 2 * 5) * 2 - kCWMinGap * 2 - kCWSideGap * 2, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }else if (idx == 4){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W184H72.png"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_W260H72.png"] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(SCREEN_SIZE.width - kCWSideGap - (kCWSideGap + (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 / 2 * 5), ((KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4 + kCHMinGap) * 3 + kCHSideGap, kCWSideGap + (SCREEN_SIZE.width - kCWMinGap * 9 - kCWSideGap * 2) / 10 / 2 * 5, (KEYBOARD_HEIGHT - kCHMinGap * 3 - kCHSideGap * 2) / 4)];
        }
    }];
    
    
    
    self.characterKeys = btns;
    self.functionKeys = funcbtns;
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
    return WTKeyFunctionInsert;
}

- (WTKeyFunction)touchFunctionEnd:(UIButton *)b{
    b.selected = NO;
    if([b.titleLabel.text isEqualToString:@"取消"]){
        return WTKeyFunctionCancel;
    }else if ([b.titleLabel.text isEqualToString:@"退格"]){
        return WTKeyFunctionDelete;
    }else if ([b.titleLabel.text isEqualToString:@"搜素"]){
        return WTKeyFunctionReturn;
    }else if ([b.titleLabel.text isEqualToString:@"   "]){
        return WTKeyFunctionInsert;
    }else if ([b.titleLabel.text isEqualToString:@"上证"] || [b.titleLabel.text isEqualToString:@"深证"]){
        return WTKeyFunctionCustom;
    }else if ([b.titleLabel.text isEqualToString:@"ABC"] || [b.titleLabel.text isEqualToString:@"123"]){
        [self.characterKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
            btn.hidden = !btn.hidden;
        }];
        [self.functionKeys enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
            btn.hidden = !btn.hidden;
        }];
    }
    return WTKeyFunctionNormal;
}

@end
