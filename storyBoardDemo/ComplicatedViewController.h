//
//  ComplicatedViewController.h
//  storyBoardDemo
//
//  Created by XcodeYang on 7/21/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ComplicatedAnimationType) {
    ComplicatedAnimationCircle = 0,
    ComplicatedAnimationGroup,
};

@interface ComplicatedViewController : UIViewController

@property (nonatomic) ComplicatedAnimationType animationType;

@end
