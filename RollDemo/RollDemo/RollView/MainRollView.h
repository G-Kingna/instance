//
//  MainRollView.h
//  RollDemo
//
//  Created by hongguan on 2018/5/31.
//  Copyright © 2018年 zsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainRollViewDelegate <NSObject>

/**
 *  点击本地图片回调方法
 *
 *  @param number 点击的第几张图片（从0开始）
 *  @param image  点击的图片
 */
- (void)clickImageNumber:(NSInteger)number Image:(UIImage *)image;

/**
 *  点击网络图片回调方法
 *
 *  @param number         点击的第几张图片（从0开始）
 *  @param imageURLString 点击的图片网址
 */
- (void)clickImageNumber:(NSInteger)number ImageURLString:(NSString *)imageURLString;

@end

@interface MainRollView : UIView

@property(nonatomic, assign)id<MainRollViewDelegate>delegate;//点击图片回调代理

/**
 *  设置图片轮播的数据源，单张图片轮播时间，是否开启轮播，数据源是否为本地
 *
 *  @param array        存放图片的数组（元素类型:UIImage）
 *  @param placeholderImage  占位图
 *  @param duration   定时器时间
 *  @param isRolling   是否开启自动轮播
 */
- (void)setImageArray:(NSArray *)array
     placeholderImage:(UIImage *)placeholderImage
             duration:(NSTimeInterval)duration
          autoRolling:(BOOL)isRolling;

/**
 *  设置pageControl的圆点颜色
 *
 *  @param normalColor   非当前页码颜色
 *  @param selectedColor  当前页码的颜色
 */
- (void)setPageControlNormalColor:(UIColor *)normalColor
                      SelectColor:(UIColor *)selectedColor;
@end
