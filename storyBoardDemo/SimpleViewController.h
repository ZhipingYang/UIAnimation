//
//  SimpleViewController.h
//  storyBoardDemo
//
//  Created by XcodeYang on 7/21/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SimpleAnimationType) {
    SimpleAnimationLine = 0,
    SimpleAnimationRotate,
    SimpleAnimationScale,
    SimpleAnimationPath
};

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionLine = 0,
    TransitionEasyIn,
    TransitionEasyOut,
    TransitionEasyInEasyOut,
    TransitionSpring
};


@interface SimpleViewController : UIViewController

@property (nonatomic) SimpleAnimationType animationType;
@property (nonatomic) TransitionType transitionType;

@end
