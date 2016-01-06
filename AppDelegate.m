//
//  AppDelegate.m
//  imageEncrypt
//
//  Created by leiiwang on 15/3/2.
//  Copyright (c) 2015年 wangleo. All rights reserved.
//

#import "AppDelegate.h"
#import "MMProgressHUD.h"
#import "AFNetworking.h"

@interface AppDelegate ()
@property (nonatomic, assign)long get_token_time;
@property (nonatomic, strong) NSString *token;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [[MMProgressHUD sharedHUD] setOverlayMode:MMProgressHUDWindowOverlayModeGradient];
    
    [self get_token_comp:^(NSString *token){
        NSLog(@"%@", token);
    }];
    
    
    //微信先用地图的测试
    #define kWeixinSDKIdentifier @"wx68f0a3b9a20696c1"
    #define kWeixinSDKSecretKey @"a4cc1be6753ce263f703436eff884d11"
    
    
    return YES;
}

//sina
//App Key：3719624016
//App Secret：1c81a7b59c38110e6229afe18ce40aaa




- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void) get_token_comp :(void (^)(NSString *token))complete{
    if(time(NULL) - _get_token_time > 7200){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFJSONResponseSerializer new]];
        [manager GET:@"http://p2p2.sinaapp.com/api/get_upload_token" parameters:nil success:
         ^(AFHTTPRequestOperation *operation, id responseObject) {
             // NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//             NSLog(@"%d %d",[responseObject isKindOfClass:[NSDictionary class]], responseObject[@"error"] );
             if ([responseObject isKindOfClass:[NSDictionary class]] && [[responseObject objectForKey:@"error"]integerValue] ==  0) {
                 [responseObject class];
                 _token =  responseObject[@"token"];
                 _get_token_time = time(NULL);
                  complete(_token);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    }else{
        complete(_token);
    }
}




@end
