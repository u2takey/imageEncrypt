//
//  ShareSquareViewController.m
//  imageEncrypter
//
//  Created by leiiwang on 15/10/17.
//  Copyright © 2015年 wangleo. All rights reserved.
//

#import "ShareSquareViewController.h"

@interface ShareSquareViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)back:(id)sender;
@end

@implementation ShareSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //detail 广场url
    NSString *squareUrl = @"http://p2p2.sinaapp.com/";
    [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:squareUrl]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
//    if ([self.webView canGoBack]) {
//        self.backBtn.hidden = NO;
//    }
    
    NSLog(@"webViewDidFinishLoad");
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError:%@", error);
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}
@end
