//
//  OFFCountingAnimationView.m
//  51offerAnimation
//
//  Created by XcodeYang on 7/29/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "OFFCountingAnimationView.h"
#import "AppDelegate.h"

@implementation OFFCountingAnimationView
{
    __weak IBOutlet NSLayoutConstraint *_imageViewWidthConstraint;
    __weak IBOutlet NSLayoutConstraint *_labelCenterY;

    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UIImageView *_imageBackView;
    __weak IBOutlet UILabel *_contentLabel;
    
    NSMutableArray *_images;
    NSTimeInterval _duration;
    
    NSString *_startStr;
    NSString *_middleStr;
    NSString *_endStr;
}

+ (OFFCountingAnimationView *)sharedView {
    NSString *classStr = NSStringFromClass([OFFCountingAnimationView class]);
    OFFCountingAnimationView *sharedView = [[[NSBundle mainBundle]loadNibNamed:classStr
                                                                         owner:nil options:nil] firstObject];
    sharedView.frame = [UIScreen mainScreen].bounds;
    return sharedView;
}

+ (void)showCountingViewWithStartStr:(NSString *)startStr
                           middleStr:(NSString *)middleStr
                              endStr:(NSString *)endStrStr
                 animateWithDuration:(NSTimeInterval)duration
                          animations:(void (^)(void))animations
{
    [[self sharedView] showCountingViewWithStartStr:startStr
                                          middleStr:middleStr
                                             endStr:endStrStr
                                animateWithDuration:duration
                                         animations:animations];
}

- (void)showCountingViewWithStartStr:(NSString *)startStr
                           middleStr:(NSString *)middleStr
                              endStr:(NSString *)endStr
                 animateWithDuration:(NSTimeInterval)duration
                          animations:(void (^)(void))animations
{
    _startStr = startStr;
    _middleStr = middleStr;
    _endStr = endStr;
    _duration = duration;
    
    _images = [NSMutableArray arrayWithCapacity:101];
    for (int i=0; i<101; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"counting_%03d",i]];
        [_images addObject:image];
    }
    
    // 计算圆的
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    _imageViewWidthConstraint.constant = sqrtf(mainSize.width * mainSize.width
                                             + mainSize.height * mainSize.height);
    _labelCenterY.constant = mainSize.width<=320 ? -45 : (mainSize.width>384 ? -65 : -55);
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    
    self.alpha = 0;
    [UIView animateWithDuration:duration *0.1 animations:^{
        self.alpha = 1;
    }];
    
    [UIView animateWithDuration:duration*0.9 animations:^{
        _imageView.backgroundColor = [UIColor colorWithRed:79/255. green:150/255. blue:230/255. alpha:1];
        
    } completion:^(BOOL finished) {
        _imageBackView.hidden = NO;
        _imageView.backgroundColor = [UIColor clearColor];
    }];
    
    [self startAnimation:0];
}

- (void)startAnimation:(NSInteger)rate
{
    if (rate == 90) {
        [self dismiss];
    } else if (rate == 100) {
        return;
    }
        
    if (rate < 30) {
        _contentLabel.text = _startStr;
    } else if (rate < 85) {
        _contentLabel.text = [NSString stringWithFormat:@"%@%@",_middleStr,[self getString]];
    } else if (rate < 95) {
        _contentLabel.text = _endStr;
    } else{
        _contentLabel.text = @"";
    }
    
    __block typeof(rate) blockRate = rate;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( _duration/100.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation:++blockRate];
    });
    _imageView.image = _images[rate];
}

- (NSString *)getString
{
    NSArray *array = @[@"牛津大学牛津大学牛津大学",@"牛津大学北京大学",@"牛津大学牛上海大学",@"牛津大学西安大学",@"牛津大学大学",@"牛津大学大学"];
    return array[arc4random()%(array.count-1)];
}

- (void)dismiss
{
    [UIView animateWithDuration:.5 animations:^{
        _imageViewWidthConstraint.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
