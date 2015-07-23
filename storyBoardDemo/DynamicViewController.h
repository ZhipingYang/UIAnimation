//
//  DynamicViewController.h
//  storyBoardDemo
//
//  Created by XcodeYang on 7/21/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DynamicAnimationType) {
    DynamicAnimationWeight = 0,
    DynamicAnimationHit,
    DynamicAnimationLink,
    DynamicAnimationSpring
};

@interface DynamicViewController : UIViewController

@property (nonatomic) DynamicAnimationType animationType;

@end
