//
//  GifViewController.m
//  storyBoardDemo
//
//  Created by XcodeYang on 7/22/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "GifViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface GifViewController ()
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, copy) NSData *one;
@property (nonatomic, copy) NSData *two;
@end

@implementation GifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"animation" withExtension:@"gif"];
    NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"pickSchoolAnimation" withExtension:@"gif"];

    _one = [NSData dataWithContentsOfURL:url1];
    _two = [NSData dataWithContentsOfURL:url2];

    [_segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    
    _imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:_one];
}

- (void)segmentChange:(UISegmentedControl *)segment
{
    _imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:segment.selectedSegmentIndex ? _two:_one];
}
@end
