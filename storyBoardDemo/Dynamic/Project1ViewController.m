//
//  Project1ViewController.m
//  DynamicsDemo
//
//  Created by XcodeYang on 15/4/10.
//  Copyright (c) 2015年 XcodeYang. All rights reserved.
//

#import "Project1ViewController.h"

@interface Project1ViewController ()
{
    NSMutableArray *_array;
    
    UIDynamicAnimator * _animator;

    UIAttachmentBehavior *_lastAttach;
    
    UIAttachmentBehavior *_firstAttach;
}
@end

@implementation Project1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    _array = [NSMutableArray array];
    
    for (int i=0; i<6; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"80"]];
        imageView.frame = CGRectMake(i*60, 200, 30, 30);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 15;
        [self.view addSubview:imageView];
        [_array addObject:imageView];
    }
    
    //物体属性
    UIDynamicItemBehavior *itemsBehavior = [[UIDynamicItemBehavior alloc]initWithItems:_array];
    itemsBehavior.angularResistance = 0.6;
    itemsBehavior.density = 10;
    itemsBehavior.elasticity = 0.6;
    itemsBehavior.friction = 0.3;
    itemsBehavior.resistance = 0.3;
    [_animator addBehavior:itemsBehavior];
    
    //重力
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:_array];
    [_animator addBehavior:gravity];
    
    //碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:_array];
    collision.collisionMode = UICollisionBehaviorModeEverything;
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collision];
    
    //约束
    _firstAttach = [[UIAttachmentBehavior alloc]initWithItem:[_array firstObject] attachedToAnchor:[[_array firstObject] center]];
    _firstAttach.anchorPoint = CGPointMake(150, 0);
    _firstAttach.length = 35;
    _firstAttach.damping = 1;
    _firstAttach.frequency = 3;
    [_animator addBehavior:_firstAttach];
    
    _lastAttach = [[UIAttachmentBehavior alloc]initWithItem:[_array lastObject] attachedToAnchor:[[_array lastObject] center]];
    _lastAttach.anchorPoint = CGPointMake(150, 80);
    _lastAttach.length = 35;
    _lastAttach.damping = 1;
    _lastAttach.frequency = 3;

    
    for (int i=1; i<_array.count; i++) {
        UIView *view = _array[i];
        UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc]initWithItem:view attachedToItem:_array[i-1]];
        attach.length = 35;
        attach.damping = 1;
        attach.frequency = 3;
        [_animator addBehavior:attach];
    }

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)pan:(UIGestureRecognizer *)pan
{
    if (pan.state==UIGestureRecognizerStateBegan) {
        if (![_animator.behaviors containsObject:_lastAttach]) {
            [_animator addBehavior:_lastAttach];
        }
    }
    
    if (pan.state==UIGestureRecognizerStateChanged) {
        CGPoint point = [pan locationInView:self.view];
        _lastAttach.anchorPoint = point;
    }
    
    if (pan.state==UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_lastAttach];
    }
}

- (void)viewDidLayoutSubviews
{
    CGPoint fp = [(UIView *)_array.firstObject center];
    CGPoint sp = [(UIView *)_array[1] center];
    
    CGFloat distance = sqrt((fp.x-sp.x)*(fp.x-sp.x)+(fp.y-sp.y)*(fp.y-sp.y));
    NSLog(@"%f",distance);
    if (distance>100) {
        [_animator removeBehavior:_firstAttach];
    }
    
}

@end
