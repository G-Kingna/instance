
此demo主要用于页面实现轮播图片功能

主要调用方法为

/**
 *  设置图片轮播的数据源，占位图，单张图片轮播时间，是否开启轮播
 *
 *  @param array  存放图片的数组
 *  @param placeholderImage  占位图
 *  @param duration  定时器时间
 *  @param isRolling  是否开启自动轮播
 */
- (void)setImageArray:(NSArray *)array placeholderImage:(UIImage *)placeholderImage duration:(NSTimeInterval)duration autoRolling:(BOOL)isRolling;

