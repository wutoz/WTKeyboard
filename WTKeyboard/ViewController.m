//
//  ViewController.m
//  WTKeyboard
//
//  Created by Yorke on 15/12/27.
//  Copyright © 2015年 wutongr. All rights reserved.
//

#import "ViewController.h"
#import "WTKeyboardUtils.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UITextField *textField5;
@property (weak, nonatomic) IBOutlet UITextField *textField6;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField1.WTKeyboardType = WTKeyboardTypeNumPad;
    self.textField2.WTKeyboardType = WTKeyboardTypeDecimalPad;
    self.textField3.WTKeyboardType = WTKeyboardTypeCardPad;
    self.textField4.WTKeyboardType = WTKeyboardTypeStockPad;
    self.textField5.WTKeyboardType = WTKeyboardTypeCharPad;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
