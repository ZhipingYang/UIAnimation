//
//  RootViewController.m
//  AnimationDemoPartOne
//
//  Created by XcodeYang on 7/19/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *subtitleArray;
@property (nonatomic, strong) NSArray *sectionTitleArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动画演示";
    
    // 简单动画
    NSArray *partOne = @[@"直线运动",@"旋转 - 2d/3d",@"放大放小",@"路径动画"];
    // 简单动画过度效果
    NSArray *partTwo = @[@"easyIn",@"easyOut",@"easyInEasyOut"];
    // 复合动画
    NSArray *partThree = @[@"周期动画",@"组合动画"];
    // 物理引擎模拟动画
    NSArray *partFour = @[@"重力",@"碰撞",@"链接",@"弹力"];
    
    // 有趣的"51offer"动画实战
    NSArray *partNext = @[@"HUD",@"下拉刷新",@"等你们的提议"];
    
    _subtitleArray = @[partOne,partTwo,partThree,partFour,partNext];
    
    _sectionTitleArray = @[@"简单动画",@"简单动画过度效果",
                           @"复合动画",@"物理引擎模拟动画",
                           @"有趣的“51offer”动画实战"];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _subtitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_subtitleArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    NSString *str = _subtitleArray[indexPath.section][indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"  %@",str];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 25)];
    label.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _sectionTitleArray[section];
    return label;
}


#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
