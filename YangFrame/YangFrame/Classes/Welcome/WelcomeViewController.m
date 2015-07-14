//
//  WelcomeViewController.m
//  MovieClient
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UIButton+ContentEdgeInsets.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Welcome";
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(15, 150, 280, 88);
    button.backgroundColor = [UIColor redColor];
//    [button setTitle:@"确定" forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"settings"] title:@"确定" titlePosition: UIViewContentModeLeft additionalSpacing:15 state:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
