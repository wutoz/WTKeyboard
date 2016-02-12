//
//  WTKeyboardButton.m
//  WTKeyboard
//
//  Created by Yorke on 16/1/24.
//  Copyright © 2016年 wutongr. All rights reserved.
//

#import "WTKeyboardButton.h"

@implementation WTKeyboardButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if(_titleHidden)
        return CGRectZero;
    else
        return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if(_titleHidden){
        return CGRectMake((self.frame.size.width - _imageSize.width) / 2, (self.frame.size.height - _imageSize.height) / 2, _imageSize.width, _imageSize.height);
    }
    else
        return [super imageRectForContentRect:contentRect];
}

@end
