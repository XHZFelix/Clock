//
//  AppDelegate.h
//  TimeClock
//
//  Created by 修怀忠 on 2018/2/2.
//  Copyright © 2018年 修怀忠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

