//
//  MenuViewController.m
//  DynamicsDemo
//
//  Created by XcodeYang on 7/24/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "MenuViewController.h"
#import "SphereMenu.h"

@interface MenuViewController ()<SphereMenuDelegate>

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.58 blue:0.27 alpha:1];
    
    UIImage *startImage = [UIImage imageNamed:@"start"];
    UIImage *image1 = [UIImage imageNamed:@"80"];
    UIImage *image2 = [UIImage imageNamed:@"80"];
    UIImage *image3 = [UIImage imageNamed:@"80"];
    NSArray *images = @[image1, image2, image3];
    SphereMenu *sphereMenu = [[SphereMenu alloc] initWithStartPoint:CGPointMake(180, 320)
                                                         startImage:startImage
                                                      submenuImages:images];
    sphereMenu.delegate = self;
    [self.view addSubview:sphereMenu];
}

- (void)sphereDidSelected:(int)index
{
    NSLog(@"sphere %d selected", index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
