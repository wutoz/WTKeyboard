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
@property (weak, nonatomic) IBOutlet UITextField *textField7;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField1.WTKeyboardType = WTKeyboardTypeNumPad;
    self.textField2.WTKeyboardType = WTKeyboardTypeDecimalPad;
    self.textField3.WTKeyboardType = WTKeyboardTypeCardPad;
    self.textField4.WTKeyboardType = WTKeyboardTypeStockPad;
    self.textField5.WTKeyboardType = WTKeyboardTypeCharPad;
    self.textField6.WTKeyboardType = WTKeyboardTypeSearchPad;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNoti:) name:UITextFieldTextDidChangeNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)receiveNoti:(NSNotification *)noti{
    UITextField *textField = noti.object;
    if([textField.text hasSuffix:@"上证"]){
        NSLog(@"上证");
    }else if ([textField.text hasSuffix:@"深证"]){
        NSLog(@"深证");
    }else{
        NSLog(@"receiveNoti");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
