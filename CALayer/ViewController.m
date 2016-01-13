//
//  ViewController.m
//  CALayer
//
//  Created by 王斌 on 16/1/8.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import "ViewController.h"

#define PHOTO_HEIGHT 150

@interface ViewController ()


@property(nonatomic, strong)CALayer *mylayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    //去掉以下注释查看其他效果
//    self.view.backgroundColor = [UIColor grayColor];
//    [self aboutCALayer];
//    
//    [self positionAndAnchorPoint];
//    
//    [self animatableProperty];
    
    
    /***** 绘制圆形头像 *****/
    CGPoint position= CGPointMake(160, 200);
    CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat cornerRadius=PHOTO_HEIGHT/2;
    CGFloat borderWidth=2;
    
    //阴影图层
    CALayer *layerShadow=[[CALayer alloc]init];
    layerShadow.bounds=bounds;
    layerShadow.position=position;
    layerShadow.cornerRadius=cornerRadius;
    layerShadow.shadowColor=[UIColor grayColor].CGColor;
    layerShadow.shadowOffset=CGSizeMake(2, 1);
    layerShadow.shadowOpacity=1;
    layerShadow.borderColor=[UIColor whiteColor].CGColor;
    layerShadow.borderWidth=borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    //自定义容器图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position=CGPointMake(160, 200);
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=PHOTO_HEIGHT/2;
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.masksToBounds=YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
    //    layer.shadowColor=[UIColor grayColor].CGColor;
    //    layer.shadowOffset=CGSizeMake(2, 2);
    //    layer.shadowOpacity=1;
    //设置边框
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=2;
    
    //设置图层代理
    layer.delegate=self;
    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    CGContextSaveGState(ctx);
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image=[UIImage imageNamed:@"icon"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextRestoreGState(ctx);
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
