//
//  TKParallaxScrollView.h
//  TKParallaxScrollView
//
//  Created by 辰己 佳祐 on 2016/01/27.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKParallaxScrollViewDelegate;

@interface TKParallaxScrollView : UIView

@property (nonatomic, assign) CGFloat headerStopOffsetHeight;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UIScrollView *baseScrollView;

@property (nonatomic, weak) id<TKParallaxScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView;
- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView isShrinkViews:(BOOL)isShrink;
- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView withMidView:(UIView *)midView;
- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView withMidView:(UIView *)midView isShrinkHeaderView:(BOOL)isShrinkHeaderView isShrinkMidView:(BOOL)isShrinkMidView;

@end

@protocol TKParallaxScrollViewDelegate <NSObject>

@optional
-(void)parallaxBaseScrollViewDidScroll:(UIScrollView *)scrollView;

@end