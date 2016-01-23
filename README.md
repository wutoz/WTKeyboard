# WTKeyboard

[![release](https://img.shields.io/badge/release-v0.1.0-orange.svg)](https://github.com/wutongr/WTKeyboard/releases) [![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/wutongr/WTKeyboard/blob/master/LICENSE)

WTKeyboard 键盘组件

## 安装

### 源文件
拷贝 `WTKeyboard/`目录下所有文件即可

### CocoaPods

```pod 'WTKeyboard'```

## 使用
```objc
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
    self.textField6.WTKeyboardType = WTKeyboardTypeSearchPad;
    self.textField6.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customNoti:) name:WTKeyboardCustomKeyNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"返回");
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"改变");
    return YES;
}

- (void)customNoti:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

```
## 支持系统
- iOS 7+

## TODO
- Rotation
