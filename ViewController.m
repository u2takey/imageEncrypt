//
//  ViewController.m
//  imageEncrypt
//
//  Created by leiiwang on 15/3/2.
//  Copyright (c) 2015年 wangleo. All rights reserved.
//

#import "ViewController.h"
#import "NSData+CommonCrypto.h"
#import "ImageUtil.h"
#import "MMProgressHUD.h"
#import "QMUIUtis.h"
#import <iAd/iAd.h>
#import "UIButton+Bootstrap.h"
#import "GTMBase64.h"
#import "QNUploadManager.h"
#import "QNUploadOption.h"


#import "ShareWxViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *codeText;
@property (strong, nonatomic) IBOutlet UIButton *btnen;
@property (strong, nonatomic) IBOutlet UIButton *btnde;
@property (strong, nonatomic) IBOutlet UIButton *btnsave;
@property (strong, nonatomic) IBOutlet UIButton *btnshare;
@property (strong, nonatomic) ADBannerView *bannerView;
@property (nonatomic ,assign) BOOL bannerIsVisible;

@property (nonatomic, strong)NSData *data;
- (IBAction)textFieldDone:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)decrypt:(id)sender;
- (IBAction)encrypt:(id)sender;
- (IBAction)share:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [self.imageView addGestureRecognizer:tap];
    
    [self.btnen primaryStyle];
    [self.btnen addAwesomeIcon:FAIconLock beforeTitle:NO];
    
    [self.btnde warningStyle];
    [self.btnde addAwesomeIcon:FAIconUnlock beforeTitle:NO];
    
    [self.btnsave successStyle];
    [self.btnsave addAwesomeIcon:FAIconSave beforeTitle:NO];
    
    [self.btnshare primaryStyle];
    [self.btnshare addAwesomeIcon:FAIconShare beforeTitle:NO];
    
    [QMUIUtis AddBorderForView:self.imageView];
    
    [self.codeText addTarget:self.codeText
                  action:@selector(resignFirstResponder)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self addBannerView];
}




- (void)addBannerView
{
    self.bannerView = [[ADBannerView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height - 50, 320, 50)];
//    self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.bannerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: self.bannerView];
}

#pragma mark - AdViewDelegates

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_bannerIsVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (_bannerView.superview == nil)
        {
            [self.view addSubview:_bannerView];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad will load");
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad did finish");
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tapImage:(id)sender {
    if ([self.codeText isFirstResponder]) {
        [self.codeText resignFirstResponder];
        return;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        // 初始化图片选择控制器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
        [controller setDelegate:self];// 设置代理
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:controller animated:YES completion:nil];
        }];
        
    } else {
        NSLog(@"Camera is not available.");
    }
}




- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction) textFieldDone:(id) sender
{
    [sender resignFirstResponder];
}

- (IBAction)save:(id)sender {
    //NSLocalizedString(@"title", nil)
    [self.codeText resignFirstResponder];
    [MMProgressHUD  showWithTitle:nil status:NSLocalizedString(@"savingTitle", nil)];
    NSData* imdata =  UIImagePNGRepresentation (self.imageView.image); // get PNG representation
    UIImage* im2 = [UIImage imageWithData:imdata]; // wrap UIImage around PNG representation
    UIImageWriteToSavedPhotosAlbum(im2, self,  @selector(photoSaved:didFinishSavingWithError:contextInfo:), nil);
}

- (void)photoSaved:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        [MMProgressHUD  dismissWithSuccess:NSLocalizedString(@"savingSuccessTitle", nil)];
    }
    else{
        [MMProgressHUD  dismissWithSuccess:NSLocalizedString(@"savingFailTitle", nil)];
    }
}



- (IBAction)decrypt:(id)sender{
    [self.codeText resignFirstResponder];
    if (self.imageView.image) {
        [MMProgressHUD  showWithTitle:nil status:NSLocalizedString(@"decryptTitle", nil) ];
        
        NSString *key1 = [self.codeText.text md5Encrypt];
        for (int i = 0; i < 20; i++) {
            key1 = [NSString stringWithFormat:@"%@%@",key1, [key1 md5Encrypt]];
        }
        NSData *ciphertext = [key1 dataUsingEncoding:NSUTF8StringEncoding];
        
        self.imageView.image = [ImageUtil imageWithImageDecode:self.imageView.image  key:(char *)ciphertext.bytes];
        [MMProgressHUD  dismissWithSuccess:NSLocalizedString(@"decryptSuccessTitle", nil) ];
    }
}



- (IBAction)encrypt:(id)sender {
    [self.codeText resignFirstResponder];
    if (self.imageView.image) {
        [MMProgressHUD  showWithTitle:nil status:NSLocalizedString(@"encryptingTitle", nil) ];
        NSString *key1 = [self.codeText.text md5Encrypt];
        for (int i = 0; i < 20; i++) {
            key1 = [NSString stringWithFormat:@"%@%@",key1, [key1 md5Encrypt]];
        }
        NSData *ciphertext = [key1 dataUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", key1);
        self.imageView.image = [ImageUtil imageWithImageCode:self.imageView.image key:(char *)ciphertext.bytes];
        [MMProgressHUD  dismissWithSuccess:NSLocalizedString(@"encryptingSucessTitle", nil) ];
    }
}


- (IBAction)share:(id)sender {
    if (!self.imageView.image){
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"分享"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"分享到微信", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        ShareWxViewController *share = [[ShareWxViewController alloc]initWithNibName:nil bundle:nil];
        share.image = self.imageView.image;
        share.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:share animated:YES];
    }
}


#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
