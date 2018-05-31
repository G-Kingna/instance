//
//  MainRollViewCell.m
//  RollDemo
//
//  Created by hongguan on 2018/5/31.
//  Copyright © 2018年 zsw. All rights reserved.
//

#import "MainRollViewCell.h"
#import "UIImageView+WebCache.h"

#define WIDTH  self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation MainRollViewCell

//添加网络图片
- (void)setImageWithString:(NSString *)string placeholderImage:(UIImage *)placeholderImage {
    
    NSURL *url = [NSURL URLWithString:string];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    imageview.userInteractionEnabled = YES;
    [imageview sd_setImageWithURL:url placeholderImage:placeholderImage];
    [self.contentView addSubview:imageview];
}

//添加本地图片
- (void)setImageWithImage:(UIImage *)image {
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    imageview.userInteractionEnabled = YES;
    [imageview setImage:image];
    [self.contentView addSubview:imageview];
}
@end
