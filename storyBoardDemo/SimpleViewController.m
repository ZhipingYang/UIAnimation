//
//  SimpleViewController.m
//  storyBoardDemo
//
//  Created by XcodeYang on 7/21/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

// constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickBottom;

// view
@property (strong, nonatomic) UIButton *animationView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@end

@implementation SimpleViewController
{
    NSInteger pickAnimationType;
    NSInteger pickTransiotionType;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)creatAnimationView
{
    if (_animationView) {
        [_animationView removeFromSuperview];
        _animationView = nil;
    }
    _animationView = [UIButton buttonWithType:UIButtonTypeCustom];
    _animationView.backgroundColor = [UIColor purpleColor];
    
    switch (_animationType) {
        case SimpleAnimationLine:
        case SimpleAnimationPath:
            _animationView.frame = CGRectMake(20, 80, 50, 50);
            break;
        case SimpleAnimationRotate:
            _animationView.frame = CGRectMake(20, 80, 300, 300);
            _animationView.center = self.view.center;
            break;
        case SimpleAnimationScale:
            _animationView.frame = CGRectMake(110, 130, 150, 150);
            _animationView.center = self.view.center;
            break;
    }
    [_animationView addTarget:self action:@selector(pickViewTrigger:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_animationView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self creatAnimationView];
    [self startAnimation:0 transition:0];
}

#pragma mark - picker delegate & datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        switch (_animationType) {
            case SimpleAnimationLine:
                return 4;
            case SimpleAnimationRotate:
                return 2;
            case SimpleAnimationScale:
                return 2;
            case SimpleAnimationPath:
                return 4;
        }
    }
    else {
        return 5;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *titleArray;
    if (component==0) {
        switch (_animationType) {
            case SimpleAnimationLine:
                titleArray = @[@"宽度",@"高度",@"水平平移",@"位置"];
                break;
            case SimpleAnimationRotate:
                titleArray = @[@"2d旋转",@"3d旋转"];
                break;
            case SimpleAnimationScale:
                titleArray = @[@"放大",@"缩小"];
                break;
            case SimpleAnimationPath:
                titleArray = @[@"路径1",@"路径2",@"路径3",@"路径4"];
                break;
        }
    }
    else {
        titleArray = @[@"Line",@"easyIn",@"easyOut",@"easyInEasyOut",@"spring",@"bounce"];
    }
    return titleArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component==0) {
        pickAnimationType = row;
    } else {
        pickTransiotionType = row;
    }
    
    [self creatAnimationView];
    [self startAnimation:pickAnimationType transition:pickTransiotionType];
}

#pragma mark - animation

- (IBAction)pickViewTrigger:(id)sender {
    
    [UIView animateWithDuration:0.65
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _pickBottom.constant = _pickBottom.constant>=0 ? -162:0;
                         [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)startAnimation:(NSInteger)type transition:(NSInteger)transition
{
    UIViewAnimationOptions option;
    switch (transition) {
        case 1:     option = UIViewAnimationOptionCurveEaseIn;      break;
        case 2:     option = UIViewAnimationOptionCurveEaseOut;     break;
        case 3:     option = UIViewAnimationOptionCurveEaseInOut;   break;
        default:    option = UIViewAnimationOptionCurveLinear;      break;
    }
    
    if (transition == TransitionSpring) {
        [UIView animateWithDuration:1.5 delay:0.3
             usingSpringWithDamping:0.3 initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self configAnimation:type];
                         } completion:nil];
    }
    else{
        [UIView animateWithDuration:1 delay:0.2 options:option animations:^{
            [self configAnimation:type];
        } completion:nil];
    }
}

- (void)configAnimation:(NSInteger)type
{
    switch (_animationType) {
        case SimpleAnimationLine:
            [self lineAnimation:type];
            break;
        case SimpleAnimationRotate:
            [self rotateAnimation:type];
            break;
        case SimpleAnimationScale:
            [self scaleAnimation:type];
            break;
        case SimpleAnimationPath:
            [self pathAnimation:type];
            break;
    }
    [self.view layoutIfNeeded];
}

// line
- (void)lineAnimation:(NSInteger)type
{
    switch (type) {
        case 0:
            _animationView.frame = CGRectMake(20, 80, 200, 50);
            break;
        case 1:
            _animationView.frame = CGRectMake(20, 80, 50, 300);
            break;
        case 2:
            _animationView.frame = CGRectMake(200, 80, 50, 50);
            break;
        case 3:
            _animationView.frame = CGRectMake(200, 300, 50, 50);
            break;
    }
}

// rotate
- (void)rotateAnimation:(NSInteger)type
{
    if (type==0) {
        _animationView.transform = CGAffineTransformRotate(_animationView.transform, M_PI);
    } else {
        _animationView.layer.transform = CATransform3DConcat(_animationView.layer.transform, CATransform3DMakeRotation(M_PI,0,1.0,0));
    }
}

// scale
- (void)scaleAnimation:(NSInteger)type
{
    _animationView.transform = CGAffineTransformScale(_animationView.transform, type ? 0.5:2, type ? 0.5:2);
}

//path
- (void)pathAnimation:(NSInteger)type
{
    switch (type) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}


@end
