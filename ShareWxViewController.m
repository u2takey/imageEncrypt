//
//  ShareWxViewController.m
//  imageEncrypter
//
//  Created by leiiwang on 15/10/17.
//  Copyright © 2015年 wangleo. All rights reserved.
//

#import "ShareWxViewController.h"
#import "QNUploadManager.h"
#import "QNUploadOption.h"
#import "MMProgressHUD.h"
#import "AppDelegate.h"
#import "UIImage+Resize.h"
#import "UIButton+Bootstrap.h"
#import "UIPlaceHolderTextView.h"

@interface ShareWxViewController ()
@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *textView;
@property (strong, nonatomic) IBOutlet UISwitch *shareToSquareOn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UILabel *placeHolder;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ShareWxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.layer.cornerRadius = 5;
    self.textView.clipsToBounds =YES;
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
    
    [self.cancelBtn primaryStyle];
    [self.cancelBtn addAwesomeIcon:FAIconBackward beforeTitle:NO];
    
    [self.shareBtn warningStyle];
    [self.shareBtn addAwesomeIcon:FAIconShare beforeTitle:NO];
    
    self.textView.placeholder = @"说点什么吧";
    
    self.icon = [self.image resizedImageToFitInSize:CGSizeMake(100, 100) scaleIfSmaller:YES];
    self.imageView.image = self.icon;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)upload:(NSString*)userid title:(NSString*)title complete:(QNUpCompletionHandler)completionHandler{
    NSString *name = [userid stringByAppendingFormat:@"%ld", time(NULL)];
    //pic url
    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://7xnjb2.com1.z0.glb.clouddn.com/", name];
    QNUploadOption *option = [[QNUploadOption alloc]initWithMime:@"image/png"
                                                 progressHandler:NULL
                                                          params:@{@"x:user_id": userid,
                                                                   @"x:title": title,
                                                                   @"x:pic_url": url,
                                                                   @"x:share" : (self.shareToSquareOn.isOn ? @"1" : @"0")
                                                                   }
                                                        checkCrc:false
                                              cancellationSignal:NULL];;
    [(AppDelegate*)[UIApplication sharedApplication].delegate get_token_comp:^(NSString * token){
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        NSData *data = UIImagePNGRepresentation (self.image);
        [upManager putData:data key:name token:token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      completionHandler(info,key, resp);
                  } option:option];
    }];
    
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

NSString* urlencode(NSString *src){
    return [src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (IBAction)share:(id)sender {
    [MMProgressHUD  showWithTitle:nil status:NSLocalizedString(@"sharingTitle", nil)];
    [self.textView resignFirstResponder];
    NSString *user_id = [[NSUUID UUID] UUIDString];
    NSString *title = self.textView.text;
    [self upload:[[NSUUID UUID] UUIDString] title: title complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"%@", info);
        NSLog(@"%@", resp);
        BOOL success = [[resp objectForKey:@"error"] integerValue] == 0;
        NSString *pic_url =  [resp objectForKey:@"pic_url"];
        if (!success || pic_url.length == 0) {
            [MMProgressHUD  dismissWithError:NSLocalizedString(@"sharingFail", nil)];
        }else{
           
//            NSString *postUrl = [NSString stringWithFormat:
//                                 @"http://p2p2.sinaapp.com/post?user_id=%@&title=%@&pic_url=%@",
//                                 urlencode(user_id), urlencode(title), urlencode(pic_url)];
//        
//            [UMSocialData defaultData].extConfig.wechatSessionData.url = postUrl;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.url = postUrl;
//            [UMSocialData defaultData].extConfig.wechatSessionData.title = self.textView.text;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.textView.text;
            
//            [UMSocialSnsService presentSnsIconSheetView:self
//                                                 appKey:@"562222e167e58eb03b0000bc"
//                                              shareText:self.textView.text
//                                             shareImage:self.icon
//                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
//                                               delegate:self];
        
     
            
            
//            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession]
//                                                                content:self.textView.text
//                                                                  image:self.image location:nil
//                                                           urlResource:resp[@"pic_url"]
//                                                    presentedController:self
//                                                             completion:^(UMSocialResponseEntity *response){
//                                                                 if (response.responseCode == UMSResponseCodeSuccess) {
//                                                                     [self.navigationController popViewControllerAnimated:YES];
//                                                                     [MMProgressHUD showWithStatus:@"分享成功"];
//                                                                 }else{
//                                            
//                                                                 }
//                                                             }];
            
            [MMProgressHUD dismissWithSuccess:NSLocalizedString(@"sharingSuccess", nil)];
            [self.navigationController popViewControllerAnimated:YES];
        }
       
    } ];
  
    
}


//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    [MMProgressHUD dismiss];
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}



@end
