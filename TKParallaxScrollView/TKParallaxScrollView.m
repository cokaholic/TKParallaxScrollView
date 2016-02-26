//
//  TKParallaxScrollView.m
//  TKParallaxScrollView
//
//  Created by 辰己 佳祐 on 2016/01/27.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "TKParallaxScrollView.h"

@interface TKParallaxScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, assign) CGFloat midViewHeight;
@property (nonatomic, assign) BOOL isShrinkHeaderView;
@property (nonatomic, assign) BOOL isShrinkMidView;

@end

@implementation TKParallaxScrollView

- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView
{
    return [self initWithFrame:frame
            withBaseScrollView:baseScrollView
                withHeaderView:headerView
                   withMidView:nil
            isShrinkHeaderView:YES
               isShrinkMidView:YES];
}

- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView isShrinkViews:(BOOL)isShrink {
    
    return [self initWithFrame:frame
            withBaseScrollView:baseScrollView
                withHeaderView:headerView
                   withMidView:nil
            isShrinkHeaderView:isShrink
               isShrinkMidView:YES];
}

- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView withMidView:(UIView *)midView
{
    return [self initWithFrame:frame
            withBaseScrollView:baseScrollView
                withHeaderView:headerView
                   withMidView:midView
            isShrinkHeaderView:YES
               isShrinkMidView:YES];
}

- (instancetype)initWithFrame:(CGRect)frame withBaseScrollView:(UIScrollView *)baseScrollView withHeaderView:(UIView *)headerView withMidView:(UIView *)midView isShrinkHeaderView:(BOOL)isShrinkHeaderView isShrinkMidView:(BOOL)isShrinkMidView {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.headerViewHeight = 0;
        self.midViewHeight = 0;
        self.headerStopOffsetHeight = 0;
        self.isShrinkHeaderView = isShrinkHeaderView;
        self.isShrinkMidView = isShrinkMidView;
        
        [self setParallaxBaseScrollView:baseScrollView];
        if (headerView) {
            [self setParallaxHeaderView:headerView];
        }
        
        if (midView) {
            [self setParallaxMidView:midView];
        }
        [self updateFrame];
        [_baseScrollView setContentOffset:CGPointMake(0, -(self.headerViewHeight + self.midViewHeight)) animated:NO];
    }
    return self;
}

- (void)setParallaxBaseScrollView:(UIScrollView *)baseScrollView {
    
    if ([_baseScrollView isDescendantOfView:self]) {
        [_baseScrollView removeFromSuperview];
        _baseScrollView = nil;
        _baseScrollView.delegate = nil;
    }
    
    _baseScrollView = baseScrollView;
    _baseScrollView.delegate = self;
    [self addSubview:_baseScrollView];
}

- (void)setParallaxHeaderView:(UIView *)headerView {
    
    if ([_headerView isDescendantOfView:self]) {
        [_headerView removeFromSuperview];
        _headerView = nil;
    }
    
    _headerView = headerView;
    _headerView.clipsToBounds = YES;
    [self addSubview:headerView];
    _headerViewHeight = (CGRectGetHeight(_headerView.frame)/CGRectGetWidth(_headerView.frame))*CGRectGetWidth(_baseScrollView.frame);
}

- (void)setParallaxMidView:(UIView *)midView {
    
    if ([_midView isDescendantOfView:self]) {
        [_midView removeFromSuperview];
        _midView = nil;
    }
    
    _midView = midView;
    _midView.clipsToBounds = YES;
    [self addSubview:midView];
    _midViewHeight = (CGRectGetHeight(_midView.frame)/CGRectGetWidth(_midView.frame))*CGRectGetWidth(_baseScrollView.frame);
    
    if (_headerView) {
        [self bringSubviewToFront:_headerView];
    }
}

- (void)updateFrame {
    
    _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), _headerViewHeight);
    
    if (_midView) {
        _midView.frame = CGRectMake(0, _headerViewHeight, CGRectGetWidth(self.frame), _midViewHeight);
    }
    
    _baseScrollView.frame = self.frame;
    _baseScrollView.contentInset = UIEdgeInsetsMake(self.headerViewHeight + self.midViewHeight, 0, 0, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([self.delegate respondsToSelector:@selector(parallaxBaseScrollViewDidScroll:)]) {
        [self.delegate parallaxBaseScrollViewDidScroll:scrollView];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY<=-(self.headerViewHeight + self.midViewHeight)) {
        _headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.headerViewHeight);
        
        if (_midView) {
            _midView.frame = CGRectMake(0, self.headerViewHeight, self.frame.size.width, self.midViewHeight);
        }
    }
    else if (offsetY<-(self.headerStopOffsetHeight + self.midViewHeight)) {
        if (self.isShrinkHeaderView) {
            _headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.headerViewHeight - (self.headerViewHeight + self.midViewHeight + offsetY));
        }
        else {
            _headerView.frame = CGRectMake(0, - (self.headerViewHeight + self.midViewHeight + offsetY), self.frame.size.width, self.headerViewHeight);
        }
        
        if (_midView) {
            _midView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), self.frame.size.width, self.midViewHeight);
        }
    }
    else if (offsetY<-self.headerStopOffsetHeight){
        if (self.isShrinkHeaderView) {
            _headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.headerStopOffsetHeight);
        }
        else {
            _headerView.frame = CGRectMake(0, self.headerStopOffsetHeight - self.headerViewHeight, self.frame.size.width, self.headerViewHeight);
        }
        
        if (self.isShrinkMidView) {
            if (_midView) {
                _midView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), self.frame.size.width, self.midViewHeight - (offsetY + self.headerStopOffsetHeight + self.midViewHeight));
            }
        }
        else {
            if (_midView) {
                _midView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame) - (offsetY + self.headerStopOffsetHeight + self.midViewHeight), self.frame.size.width, self.midViewHeight);
            }
        }
    }
    else {
        
        if (self.isShrinkHeaderView) {
            _headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.headerStopOffsetHeight);
        }
        else {
            _headerView.frame = CGRectMake(0, self.headerStopOffsetHeight - self.headerViewHeight, self.frame.size.width, self.headerViewHeight);
        }
        
        if (self.isShrinkMidView) {
            if (_midView) {
                _midView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), self.frame.size.width, 0);
            }
        }
        else {
            if (_midView) {
                _midView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame) - self.midViewHeight, self.frame.size.width, self.midViewHeight);
            }
        }
    }
    
//    NSLog(@"offsetY: %f", offsetY);
}

- (void)dealloc {
    
    _baseScrollView.delegate = nil;
}

@end
