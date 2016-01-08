//
//  ViewController.m
//  CALayer
//
//  Created by 王斌 on 16/1/8.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong)CALayer *mylayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self aboutCALayer];
    
    [self positionAndAnchorPoint];
    
    [self animatableProperty];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)aboutCALayer{
    
    
    UIView *viewSample = [[UIView alloc] init];
    [self.view addSubview:viewSample];
    viewSample.backgroundColor = [UIColor greenColor];
    viewSample.frame = CGRectMake(100, 50, 100, 100);

    //Test 1 阴影
    //viewSample.layer.shadowPath = [UIBezierPath bezierPathWithRect:viewSample.bounds].CGPath;
    viewSample.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)].CGPath;
    //如果设置了超过主图层的部分减掉，则设置阴影不会有显示效果。
    viewSample.layer.masksToBounds = NO;
    //设置阴影的偏移量，如果为正数，则代表为往右边偏移，默认(0, -3)
    viewSample.layer.shadowOffset = CGSizeMake(10, 10);
    //模糊半径, 默认是3
    viewSample.layer.shadowRadius = 5;
    //阴影透明度，0-1之间，0表示完全透明, 默认0
    viewSample.layer.shadowOpacity = 0.5;
    //阴影颜色, 默认为不透明的黑色
    viewSample.layer.shadowColor = [UIColor blackColor].CGColor;
    
    //Test 2 边框
    viewSample.layer.borderWidth = 2;
    viewSample.layer.borderColor = [[UIColor redColor] CGColor];
    
    //Test 3 masksToBounds
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 500, 500)];
    btn.backgroundColor = [UIColor lightGrayColor];
    //[viewSample addSubview:btn];
    //viewSample.layer.masksToBounds = true;
    
    //Test 4 bounds 会改变view的显示大小
    //viewSample.layer.bounds = CGRectMake(200, 200, 500, 500);
    
    //Test 5 透明度，默认1，不透明
    viewSample.layer.opacity = 0.5;
    
    //Test 6 圆角半径，默认0
    viewSample.layer.cornerRadius = 10;
    
    //test 7 contents 在view的图层上添加一个image
    viewSample.layer.contents=(id)[UIImage imageNamed:@"play_button"].CGImage;
    //viewSample.layer.masksToBounds = YES; //设置超过子图层的部分裁减掉
    
}

#pragma mark - layer位置
- (void)positionAndAnchorPoint{
    
    //greenLayer
    CALayer *greenLayer = [CALayer layer];
//    greenLayer.bounds = CGRectMake(200, 400, 150, 150);
    greenLayer.frame = CGRectMake(100, 200, 120, 120);
    greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    greenLayer.anchorPoint = CGPointZero;
    greenLayer.position = CGPointMake(100, 180);
    
    //redLayer
    CALayer *redLayer = [CALayer layer];
//    redLayer.bounds = CGRectMake(200, 400, 80, 80);
    redLayer.frame = CGRectMake(20, 40, 80, 80);
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    redLayer.position = CGPointMake(0, 0);
    redLayer.anchorPoint = CGPointZero;
    [greenLayer addSublayer:redLayer];
    
    [self.view.layer addSublayer:greenLayer];

}

#pragma mark - 隐式动画

- (void)animatableProperty{
    
   
    
    //创建图层
    self.mylayer =[CALayer layer];
    //设置图层属性
    self.mylayer.backgroundColor = [UIColor orangeColor].CGColor;
    self.mylayer.bounds = CGRectMake(0, 0, 80, 80);
    //显示位置
    self.mylayer.position = CGPointMake(100, 400);
    self.mylayer.anchorPoint = CGPointMake(0.5, 0.5);
    self.mylayer.cornerRadius = 20;
    self.mylayer.opacity = 0.8;
    self.mylayer.masksToBounds = YES;
    //添加图层
    [self.view.layer addSublayer:self.mylayer];


    //在layer上添加图片，
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [imageView setImage:[UIImage imageNamed:@"robot"]];
    self.mylayer.contents = (id)[UIImage imageNamed:@"robot"].CGImage;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //想关闭隐式动画，只需在layer的值改变前后加入三行代码
    //[CATransaction begin];
    //[CATransaction setDisableActions:YES];
    //隐式动画
    self.mylayer.bounds=CGRectMake(0, 0, 120, 120);
    self.mylayer.opacity = 1;
    self.mylayer.backgroundColor=[UIColor greenColor].CGColor;
    //[CATransaction commit];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //隐式动画
    self.mylayer.bounds = CGRectMake(0, 0, 80, 80);
    self.mylayer.opacity = 0.8;
    self.mylayer.backgroundColor = [UIColor orangeColor].CGColor;
}











@end
