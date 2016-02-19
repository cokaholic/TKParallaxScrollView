//
//  TKViewController.m
//  TKParallaxScrollView
//
//  Created by cztatsumi-keisuke on 02/19/2016.
//  Copyright (c) 2016 cztatsumi-keisuke. All rights reserved.
//

#import "TKViewController.h"
#import "TKParallaxScrollView.h"

@interface TKViewController ()

@end

@implementation TKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView *testHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150)];
    testHeaderView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    testHeaderView.userInteractionEnabled = NO;
    
    UIView *testMidView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    testMidView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    testMidView.userInteractionEnabled = NO;
    
    
    UIScrollView *testScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    testScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(testHeaderView.frame) + CGRectGetHeight(testMidView.frame) + CGRectGetHeight(self.view.frame));
    
    TKParallaxScrollView *scrollView = [[TKParallaxScrollView alloc]initWithFrame:self.view.frame
                                                               withBaseScrollView:testScrollView
                                                                   withHeaderView:testHeaderView
                                                                      withMidView:testMidView
                                                                    isShrinkViews:YES];
    scrollView.headerStopOffsetHeight = 40;
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
