//
//  ViewController.m
//  RollDemo
//
//  Created by hongguan on 2018/5/30.
//  Copyright © 2018年 zsw. All rights reserved.
//

#import "ViewController.h"
#import "MainRollView.h"

@interface ViewController ()
<
MainRollViewDelegate
>

@property(nonatomic, strong)NSMutableArray *imageNetworkArr;//网络图片数组
@property(nonatomic, strong)NSMutableArray *localImageArr;//本地图片数组

@end

@implementation ViewController

- (NSMutableArray *)imageNetworkArr {
    if (!_imageNetworkArr) {
        _imageNetworkArr = [NSMutableArray array];
    }
    return _imageNetworkArr;
}

- (NSMutableArray *)localImageArr {
    if (!_localImageArr) {
        _localImageArr = [NSMutableArray array];
    }
    return _localImageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //网络图片
    [self.imageNetworkArr addObject:@"http://img.hb.aicdn.com/00cbf80c21157f6f8c2de3974bda815d05abc81e1b57ae-DqUbbC_fw658"];
    [self.imageNetworkArr addObject:@"http://img.hb.aicdn.com/774df8f39921ca42f03be2f3ee777071bd3940a015e5c2-Pgq1ji_fw658"];
    [self.imageNetworkArr addObject:@"http://img.hb.aicdn.com/7235c4403ae98161aa9e2758ce365ca02980870413f76e-NIUsjj_fw658"];
    [self.imageNetworkArr addObject:@"http://img.hb.aicdn.com/534bc45e96db7f5a92fd58518ca5d1d2ef18b5404488b-lx54gD_fw658"];
    [self.imageNetworkArr addObject:@"http://img.hb.aicdn.com/3f30730c03e766e8e0b1231b93617506f5fe47674a8db-Qdlj2x_fw658"];
//    [self creatSubviewWithArr:self.imageNetworkArr];
    
    //本地图片
        [self setImageToSubview];
}

- (void)setImageToSubview {
    for (int i = 0; i < 3; i++) {
        [self.localImageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
    }
    [self creatSubviewWithArr:self.localImageArr];
}

- (void)creatSubviewWithArr:(NSMutableArray *)arr {
    MainRollView *main = [[MainRollView alloc] initWithFrame:(CGRectMake(0, 50, self.view.frame.size.width, 250))];
    main.delegate = self;
    [main setImageArray:arr placeholderImage:[UIImage imageNamed:@"3.png"] duration:2 autoRolling:NO];
    [main setPageControlNormalColor:[self colorWithHex:@"F5F5F5"] SelectColor:[self colorWithHex:@"87CEFA"]];
    [self.view addSubview:main];
}

- (void)clickImageNumber:(NSInteger)number Image:(UIImage *)image {
    NSLog(@"第%ld张", (long)number);
}

- (void)clickImageNumber:(NSInteger)number ImageURLString:(NSString *)imageURLString  {
    NSLog(@"第%ld张", (long)number);
    NSLog(@"图片地址---%@", imageURLString);
}

//颜色十六进制值转换
- (UIColor *)colorWithHex:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
