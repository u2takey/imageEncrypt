//
//  UIPlaceHolderTextView.h
//  imageEncrypter
//
//  Created by leiiwang on 15/10/17.
//  Copyright © 2015年 wangleo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end