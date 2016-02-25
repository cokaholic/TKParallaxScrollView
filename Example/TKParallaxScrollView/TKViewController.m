//
//  TKViewController.m
//  TKParallaxScrollView
//
//  Created by cztatsumi-keisuke on 02/19/2016.
//  Copyright (c) 2016 cztatsumi-keisuke. All rights reserved.
//

#import "TKViewController.h"
#import "TKParallaxScrollView.h"

#define RECT_PERCENT CGRectGetWidth(self.view.frame)/320.0f

@interface TKViewController ()

@end

@implementation TKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImageView *testHeaderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 192*RECT_PERCENT)];
    testHeaderView.image = [UIImage imageNamed:@"img_header"];
    testHeaderView.backgroundColor = [UIColor clearColor];
    testHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    testHeaderView.userInteractionEnabled = NO;
    testHeaderView.alpha = 0.6;
    
    UIImageView *testMidView = [[UIImageView alloc]initWithFrame:testHeaderView.frame];
    testMidView.image = [UIImage imageNamed:@"img_mid"];
    testMidView.backgroundColor = [UIColor clearColor];
    testMidView.contentMode = UIViewContentModeScaleAspectFill;
    testMidView.userInteractionEnabled = NO;
    
    UIScrollView *testScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    testScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(testHeaderView.frame) + CGRectGetHeight(testMidView.frame) + CGRectGetHeight(self.view.frame));
    
    TKParallaxScrollView *scrollView = [[TKParallaxScrollView alloc]initWithFrame:self.view.frame
                                                               withBaseScrollView:testScrollView
                                                                   withHeaderView:testHeaderView
                                                                      withMidView:testMidView
                                                                    isShrinkHeaderView:NO
                                                                  isShrinkMidView:NO];
    scrollView.headerStopOffsetHeight = 64;
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
