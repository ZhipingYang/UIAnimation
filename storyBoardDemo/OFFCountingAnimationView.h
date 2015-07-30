//
//  OFFCountingAnimationView.h
//  51offerAnimation
//
//  Created by XcodeYang on 7/29/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFFCountingAnimationView : UIView

+ (void)showCountingViewWithStartStr:(NSString *)start
                           middleStr:(NSString *)middle
                              endStr:(NSString *)endStr
                 animateWithDuration:(NSTimeInterval)duration
                          animations:(void (^)(void))animations;

@end
