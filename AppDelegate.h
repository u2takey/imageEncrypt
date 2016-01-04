//
//  AppDelegate.h
//  imageEncrypt
//
//  Created by leiiwang on 15/3/2.
//  Copyright (c) 2015年 wangleo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void) get_token_comp :(void (^)(NSString *token))complete;

@end

