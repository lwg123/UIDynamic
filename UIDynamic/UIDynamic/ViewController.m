//
//  ViewController.m
//  UIDynamic
//
//  Created by weiguang on 16/6/22.
//  Copyright © 2016年 weiguang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;


//物理仿真器
@property(nonatomic,strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (UIDynamicAnimator *)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //[self testGravity];
    //[self testCollision2];
    [self testCollision];
    //获得触摸点
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.view];
//    
//    //创建吸附行为
//    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.blueView snapToPoint:point];
//    // 防抖系数(值越小, 越抖)
//    snap.damping = 0.5;
//    
//    [self.animator removeAllBehaviors];
//    [self.animator addBehavior:snap];
    
}

- (void)testCollision2{
    // 1.创建 碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.blueView];
    //    [collision addItem:self.segment];
    //    // 添加边界
    //        CGFloat startX = 0;
    //        CGFloat startY = self.view.frame.size.height * 0.5;
    //        CGFloat endX = self.view.frame.size.width;
    //        CGFloat endY = self.view.frame.size.height;
    //        [collision addBoundaryWithIdentifier:@"line1" fromPoint:CGPointMake(startX, startY) toPoint:CGPointMake(endX, endY)];
    //        [collision addBoundaryWithIdentifier:@"line2" fromPoint:CGPointMake(endX, 0) toPoint:CGPointMake(endX, endY)];
    
    CGFloat width = self.view.frame.size.width;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    
    // 2.创建物理仿真行为 - 重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    gravity.magnitude = 10;
    [gravity addItem:self.blueView];
    
    // 3.添加行为
    [self.animator addBehavior:collision];
    [self.animator addBehavior:gravity];
}

- (void)testCollision{
    // 1.创建 碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    // 让参照视图的bounds变为碰撞检测的边框
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [collision addItem:self.blueView];
    [collision addItem:self.segment];
    
    //创建物理仿真行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    gravity.magnitude = 1;
    [gravity addItem:self.blueView];
    
    //添加行为
    [self.animator addBehavior:collision];
    [self.animator addBehavior:gravity];
    
}


- (void)testGravity{
    
    //1.创建物理仿真行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.blueView];
    //重力方向
    //    gravity.gravityDirection = CGVectorMake(100, 100);
    // 重力加速度()
    gravity.magnitude = 10;
    // 2.添加 物理仿真行为 到 物理仿真器 中, 开始物理仿真
    [self.animator addBehavior:gravity];
}

@end
