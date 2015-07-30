//
//  ComplicatedViewController.m
//  storyBoardDemo
//
//  Created by XcodeYang on 7/21/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "ComplicatedViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface ComplicatedViewController ()

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageObe;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageTwo;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageThree;

@property (strong, nonatomic) UIImageView *imagee;


@end

@implementation ComplicatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageObe.hidden = YES;
    _imageTwo.hidden = YES;
    _imageThree.hidden = YES;
    
    if (_animationType == ComplicatedAnimationGroup) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadShareImage:[UIImage imageNamed:@"jjj.jpg"] whiteSide:YES];
        });
    }
    else{
        NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"JHChainableAnimationsExample1" withExtension:@"gif"];
        NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"JHChainableAnimationsExample2" withExtension:@"gif"];
        NSURL *url3 = [[NSBundle mainBundle] URLForResource:@"JHChainableAnimationsExample3" withExtension:@"gif"];
        
        NSData *one = [NSData dataWithContentsOfURL:url1];
        NSData *two = [NSData dataWithContentsOfURL:url2];
        NSData *three = [NSData dataWithContentsOfURL:url3];
        
        
        _imageObe.animatedImage = [FLAnimatedImage animatedImageWithGIFData:one];
        _imageTwo.animatedImage = [FLAnimatedImage animatedImageWithGIFData:two];
        _imageThree.animatedImage = [FLAnimatedImage animatedImageWithGIFData:three];
    }
}

- (void)loadShareImage:(UIImage *)image whiteSide:(BOOL)haveSide
{
    [_imagee removeFromSuperview];
    _imagee = nil;
    _imagee = [[UIImageView alloc]initWithImage:image];
    _imagee.frame = CGRectMake(0, 0, 340*0.7, 340*0.7*(image.size.height/image.size.width));
    _imagee.center = self.view.center;
    _imagee.layer.shadowColor = [UIColor blackColor].CGColor;
    _imagee.layer.shadowOffset = CGSizeMake(2, 3);
    _imagee.layer.shadowRadius = 8;
    _imagee.layer.shadowOpacity = 0.6;
    if (haveSide) {
        _imagee.layer.borderWidth = 5;
        _imagee.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
    [self.view addSubview:_imagee];
    [self startAnimation];
}

- (void)startAnimation
{
    _imagee.transform = CGAffineTransformRotate(_imagee.transform, (M_PI/6));
    _imagee.transform = CGAffineTransformScale(_imagee.transform, 4, 4);
    _imagee.alpha = 0.5;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _imagee.center = self.view.center;
        _imagee.transform = CGAffineTransformRotate(_imagee.transform, -M_PI/6);
        _imagee.transform = CGAffineTransformScale(_imagee.transform, 1/4.0, 1/4.0);
        _imagee.alpha = 1;
        _imagee.contentScaleFactor = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _imagee.transform = CGAffineTransformRotate(_imagee.transform, (-M_PI/12));
        } completion:nil];
    }];
}


@end
