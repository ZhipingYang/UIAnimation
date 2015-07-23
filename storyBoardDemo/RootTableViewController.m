//
//  RootTableViewController.m
//  storyBoardDemo
//
//  Created by XcodeYang on 7/21/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "RootTableViewController.h"
#import "SimpleViewController.h"
#import "ComplicatedViewController.h"
#import "DynamicViewController.h"
#import "OfferViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *pushVC = [segue destinationViewController];


    if ([pushVC isKindOfClass:[SimpleViewController class]]) {
        SimpleViewController *vc = (SimpleViewController *)pushVC;
       
        // 简单动画
        if ([segue.identifier isEqualToString:@"line"]) {
            vc.animationType = SimpleAnimationLine;
        }
        else if ([segue.identifier isEqualToString:@"rotate"]) {
            vc.animationType = SimpleAnimationRotate;
        }
        else if ([segue.identifier isEqualToString:@"scale"]) {
            vc.animationType = SimpleAnimationScale;
        }
        else if ([segue.identifier isEqualToString:@"path"]) {
            vc.animationType = SimpleAnimationPath;
        }
        
        // 过渡效果
        else if ([segue.identifier isEqualToString:@"easyIn"]){
            vc.transitionType = TransitionEasyIn;
        }
        else if ([segue.identifier isEqualToString:@"easyOut"]) {
            vc.transitionType = TransitionEasyOut;
        }
        else if ([segue.identifier isEqualToString:@"inOut"]) {
            vc.transitionType = TransitionEasyInEasyOut;
        }

    }
    
    
    // 复合动画
    if ([pushVC isKindOfClass:[ComplicatedViewController class]]) {
        ComplicatedViewController *vc = (ComplicatedViewController *)pushVC;
        if ([segue.identifier isEqualToString:@"circle"]) {
            vc.animationType = ComplicatedAnimationCircle;
        }
        else if ([segue.identifier isEqualToString:@"group"]) {
            vc.animationType = ComplicatedAnimationGroup;
        }
    }

    
    // 物理引擎
    if ([pushVC isKindOfClass:[DynamicViewController class]]) {
        DynamicViewController *vc = (DynamicViewController *)pushVC;
        if ([segue.identifier isEqualToString:@"weight"]) {
            vc.animationType = DynamicAnimationWeight;
        }
        else if ([segue.identifier isEqualToString:@"hit"]) {
            vc.animationType = DynamicAnimationHit;
        }
        else if ([segue.identifier isEqualToString:@"link"]) {
            vc.animationType = DynamicAnimationLink;
        }
        else if ([segue.identifier isEqualToString:@"spring"]) {
            vc.animationType = DynamicAnimationSpring;
        }
    }

    
    // 51offer
    if ([pushVC isKindOfClass:[OfferViewController class]]) {
        OfferViewController *vc = (OfferViewController *)pushVC;
        if ([segue.identifier isEqualToString:@"HUD"]) {
            
        }
        else if ([segue.identifier isEqualToString:@"refresh"]) {
            
        }
    }
}


@end
