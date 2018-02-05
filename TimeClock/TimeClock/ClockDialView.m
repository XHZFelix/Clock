//
//  ClockDialView.m
//  TimeClock
//
//  Created by 修怀忠 on 2018/2/2.
//  Copyright © 2018年 修怀忠. All rights reserved.
//

#import "ClockDialView.h"

@interface ClockDialView()
@property(nonatomic, strong) CALayer *hourLayer;
@property(nonatomic, strong) CALayer *miniteLayer;
@property(nonatomic, strong) CALayer *secondLayer;
@property (nonatomic, assign) CGFloat scale;
@end;

static const CGFloat width = 270.0;

@implementation ClockDialView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    self.scale = self.bounds.size.width / width;
    //圆心
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    circleView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    circleView.clipsToBounds = YES;
    circleView.layer.cornerRadius = circleView.bounds.size.width / 2;
    circleView.backgroundColor = [UIColor blackColor];
    [self addSubview:circleView];
    
    for (int i = 0; i < 3; i ++) {
        CALayer *layer = [CALayer layer];
        layer.shouldRasterize = YES;
        [self.layer addSublayer:layer];
        layer.backgroundColor =[UIColor blackColor].CGColor;
         layer.anchorPoint = CGPointMake(0.5, 1);
        layer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        if (i == 0) {
            self.hourLayer = layer;
            layer.bounds = CGRectMake(0, 0, 2, 80 * self.scale);
        }else if (i == 1){
            self.miniteLayer = layer;
            layer.bounds = CGRectMake(0, 0, 2, 90 * self.scale);
        }else{
            self.secondLayer = layer;
            layer.bounds = CGRectMake(0, 0, 2, 100 * self.scale);
        }
    }
    
    //文字
     NSArray *timeArray = @[@"12",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    for (int i  = 0; i < timeArray.count; i ++) {
        CGFloat x = circleView.center.x + sin(2 *M_PI / timeArray.count *i) *(self.bounds.size.width / 2 - 20 * self.scale);
        CGFloat y = circleView.center.y - cos(2 *M_PI / timeArray.count *i) *(self.bounds.size.height / 2 - 20 * self.scale);
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x - 10 * self.scale, y - 10 * self.scale, 20 * self.scale, 20 * self.scale)];
        timeLabel.font = [UIFont boldSystemFontOfSize:15 * self.scale];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.text = timeArray[i];
        [self addSubview:timeLabel];
    }
    
    CGRect dialRect = CGRectMake(1, 1, self.bounds.size.width - 2 *self.scale, self.bounds.size.height - 2* self.scale);
    //画圆
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:dialRect];
    bezierPath.lineWidth = 2 * self.scale;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    UIColor *strokeColor = [UIColor orangeColor];
    [strokeColor set];
//    [bezierPath stroke];
    
    //画刻度
    CGFloat perAngle = M_PI / 30;
    for (int i = 0; i < 60; i ++) {
        //刻度起点
        CGFloat startAngle = (-M_PI + perAngle *i);
        CGFloat endAngle =  startAngle + perAngle / 8;
        UIBezierPath *sclaePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:self.bounds.size.width/ 2 - 2.5 * self.scale startAngle:startAngle endAngle:endAngle clockwise:YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        if (i % 5 == 0) {
            shapeLayer.strokeColor = [UIColor redColor].CGColor;
            shapeLayer.lineWidth = 10 * self.scale;
        }else{
            sclaePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:self.bounds.size.width/ 2 startAngle:startAngle endAngle:endAngle clockwise:YES];
            shapeLayer.strokeColor = [UIColor grayColor].CGColor;
            shapeLayer.lineWidth = 5 * self.scale;
        }
        shapeLayer.path = sclaePath.CGPath;
        [self.layer addSublayer:shapeLayer];
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCounter) userInfo:nil repeats:YES];
}


- (void)timeCounter{
    NSDate *currentDate = [NSDate date];//当前时间
    NSCalendar *calendar = [NSCalendar currentCalendar];//当前用户的calendar
    NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitDay fromDate:currentDate];
    NSInteger hour = [components hour]>12?([components hour] - 12):[components hour];
    NSInteger minite = [components minute];
    NSInteger second = [components second];
    
    CGFloat angle = (hour / 12.0) * 2 *M_PI + (minite / 60.0 / 12.0) *2 *M_PI + (second / 60.0 / 60.0 / 12) *2 *M_PI;
    self.hourLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    CGFloat angle1 = (minite / 60.0) *2 *M_PI + (second / 60.0 / 60.0) *2 *M_PI;
    self.miniteLayer.transform = CATransform3DMakeRotation(angle1, 0, 0, 1);
    CGFloat angle2 = (second / 60.0) *2 *M_PI;
    self.secondLayer.transform = CATransform3DMakeRotation(angle2, 0, 0, 1);
}


@end
