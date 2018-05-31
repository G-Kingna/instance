//
//  MainRollView.m
//  RollDemo
//
//  Created by hongguan on 2018/5/31.
//  Copyright © 2018年 zsw. All rights reserved.
//

#import "MainRollView.h"
#import "MainRollViewCell.h"

#define WIDTH   self.frame.size.width
#define HEIGHT self.frame.size.height

@interface MainRollView ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
{
    BOOL              _isLocalImage;
    NSInteger         _page;
    UIColor          *_normalColor;
    UIColor          *_selectColor;
    UIPageControl    *_pageControl;
    NSMutableArray   *_imageArr;
    UICollectionView *_collection;
    UIImage *_placeholderImage;
}
@end

@implementation MainRollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self collection];
    [self creatPageContolSubview];
}

- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.bounces = NO;
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.pagingEnabled = YES;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.contentOffset = CGPointMake(WIDTH, 0);
        [_collection registerClass:[MainRollViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collection];
    }
    return _collection;
}

- (void)creatPageContolSubview {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT - 30, WIDTH, 30)];
    [_pageControl setNumberOfPages:[_imageArr count] - 2];
    [_pageControl setCurrentPageIndicatorTintColor:_selectColor];
    [_pageControl setPageIndicatorTintColor:_normalColor];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    [_pageControl addTarget:self
                     action:@selector(pageAction:)
           forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

#pragma mark - Methods
- (void)setImageArray:(NSArray *)array
     placeholderImage:(UIImage *)placeholderImage
             duration:(NSTimeInterval)duration
          autoRolling:(BOOL)isRolling {
    
    if([[array firstObject] isKindOfClass:[NSString class]]) {
        _isLocalImage = NO;
    } else if([[array firstObject] isKindOfClass:[UIImage class]]){
        _isLocalImage = YES;
    } else {
        NSLog(@"数据源属性不符合要求，请使用UIImage或者NSString类型");
    }
    _placeholderImage = placeholderImage;
    _imageArr = [NSMutableArray arrayWithArray:array];
    NSString *first = [_imageArr firstObject];
    NSString *last = [_imageArr lastObject];
    [_imageArr insertObject:last atIndex:0];
    [_imageArr addObject:first];
    
    // 计时器,每隔几秒
    if (isRolling) {
        [NSTimer scheduledTimerWithTimeInterval:duration
                                         target:self
                                       selector:@selector(timerAction:)
                                       userInfo:nil
                                        repeats:YES];
    }
}

//设置pageControl颜色
- (void)setPageControlNormalColor:(UIColor *)normalColor
                      SelectColor:(UIColor *)selectedColor {
    
    _normalColor = normalColor;
    _selectColor = selectedColor;
}

#pragma mark - CollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainRollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (_isLocalImage) {
        [cell setImageWithImage:[_imageArr objectAtIndex:indexPath.row]];
    } else if (!_isLocalImage){
        [cell setImageWithString:[_imageArr objectAtIndex:indexPath.row] placeholderImage:_placeholderImage];
    }  else {
        NSLog(@"传递的数组与后面的BOOL值不匹配!!!");
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return _imageArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(WIDTH, HEIGHT);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isLocalImage && [[_imageArr objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]) {
        NSInteger currentPage = _page;
        // 假如当前是滚动到第0下标的那张图片,则返回到调用界面的应该是所提供的图片的最后一个
        if (currentPage == 0) {
            [self.delegate clickImageNumber:0
                                      Image:[_imageArr objectAtIndex:indexPath.row]];
            return;
        }
        // 假如当前滚动到得是最后一张图片,则返回的应该是所提供的第一张图片
        if (currentPage == self.collection.contentSize.width/WIDTH-1) {
            currentPage =0;
            [self.delegate clickImageNumber:currentPage
                                      Image:[_imageArr objectAtIndex:indexPath.row]];
            return;
        }
        // 假如以上两种情况都不符合,则是说明他在中间,只需要减一就可以
        currentPage--;
        [self.delegate clickImageNumber:currentPage
                                  Image:[_imageArr objectAtIndex:indexPath.row]];
        
    } else if (!_isLocalImage && [[_imageArr objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]){
        NSInteger currentPage = _page;
        // 假如当前是滚动到第0下标的那张图片,则返回到调用界面的应该是所提供的图片的最后一个
        if (currentPage == 0) {
            [self.delegate clickImageNumber:0
                             ImageURLString:[_imageArr objectAtIndex:indexPath.row]];
            return;
        }
        // 假如当前滚动到得是最后一张图片,则返回的应该是所提供的第一张图片
        if (currentPage == self.collection.contentSize.width/WIDTH-1) {
            currentPage =0;
            [self.delegate clickImageNumber:currentPage
                             ImageURLString:[_imageArr objectAtIndex:indexPath.row]];
            return;
        }
        // 假如以上两种情况都不符合,则是说明他在中间,只需要减一就可以
        currentPage--;
        [self.delegate clickImageNumber:currentPage
                         ImageURLString:[_imageArr objectAtIndex:indexPath.row]];
    }
    
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = _collection.contentOffset.x / WIDTH - 1;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _page = _collection.contentOffset.x/WIDTH;
    if (_collection.contentOffset.x == _collection.contentSize.width-WIDTH) {
        _collection.contentOffset = CGPointMake(WIDTH, 0);
        _page = 1;
    }if (_collection.contentOffset.x == 0) {
        _collection.contentOffset = CGPointMake(_collection.contentSize.width-WIDTH*2, 0);
        _page = _collection.contentSize.width/WIDTH-2;
    }
}

#pragma mark - Action
- (void)pageAction:(id)sender {
    UIPageControl *page = (UIPageControl *)sender;
    CGFloat value = page.currentPage * WIDTH;
    [self.collection setContentOffset:CGPointMake(value, 0) animated:YES];
}

-(void)timerAction:(NSTimer *)timer {
    _page++;
    CGFloat offwidth = WIDTH*_page;
    NSInteger number = self.collection.contentSize.width/WIDTH;
    [self.collection setContentOffset:CGPointMake(offwidth, 0) animated:YES];
    if (_page == number-1) {
        _page = 1;
        self.collection.contentOffset = CGPointMake(0, 0);
    }
}

@end
