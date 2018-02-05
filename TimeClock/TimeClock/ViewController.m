//
//  ViewController.m
//  TimeClock
//
//  Created by 修怀忠 on 2018/2/2.
//  Copyright © 2018年 修怀忠. All rights reserved.
//

#import "ViewController.h"
#import "ClockDialView.h"

#define S_W [UIScreen mainScreen].bounds.size.width
#define S_H [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
//表盘
@property (nonatomic, strong) ClockDialView *clockDialView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    [self.view addSubview:self.clockDialView];
}

- (ClockDialView *)clockDialView{
    if (!_clockDialView) {
        _clockDialView = [[ClockDialView alloc] initWithFrame:CGRectMake(0, 0, S_W / 3 * 2, S_W / 3 * 2)];
        _clockDialView.backgroundColor = [UIColor clearColor];
        _clockDialView.center = CGPointMake(S_W / 2, S_H / 2);
    }
    return _clockDialView;
}



@end
