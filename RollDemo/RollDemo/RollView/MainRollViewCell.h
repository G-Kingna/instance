//
//  MainRollViewCell.h
//  RollDemo
//
//  Created by hongguan on 2018/5/31.
//  Copyright © 2018年 zsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainRollViewCell : UICollectionViewCell

//添加网络图片
- (void)setImageWithString:(NSString *)string placeholderImage:(UIImage *)placeholderImage;
//添加本地图片
- (void)setImageWithImage:(UIImage *)image;

@end
