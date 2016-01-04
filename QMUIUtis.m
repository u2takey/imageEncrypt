//
//  QMUiUtis.m
//  SOSOMap
//
//  Created by leiiwang on 14-6-6.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "QMUIUtis.h"


@implementation QMUIUtis

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


// 给imgview设置 拉伸图片
+(void)setImgViewWithStrethImg:(UIImageView *)imageView imgName:(NSString *)imgName{
    UIImage *img = [UIImage imageNamed:imgName];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(6.0, 6.0, 6.0, 6.0);
    if ([img respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
        [imageView setImage:[img resizableImageWithCapInsets:edgeInsets]];
    }
    else
    {
        [imageView setImage:[img stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top]];
    }
}

// 给button 设置拉伸图片
+(void)setButtonWithStrethImg:(UIButton *)aButton imgN: (UIImage *)imageNormal imgP: (UIImage*)imagePressed edgeInsets:(UIEdgeInsets) edgeInsets{
    if ([imageNormal respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
        [aButton setBackgroundImage:[imageNormal resizableImageWithCapInsets:edgeInsets] forState:UIControlStateNormal];
        [aButton setBackgroundImage:[imagePressed resizableImageWithCapInsets:edgeInsets] forState:UIControlStateHighlighted];
        [aButton setBackgroundImage:[imagePressed resizableImageWithCapInsets:edgeInsets] forState:UIControlStateSelected];
    }
    else
    {
        [aButton setBackgroundImage:[imageNormal stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] forState:UIControlStateNormal];
        [aButton setBackgroundImage:[imagePressed stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top]forState:UIControlStateHighlighted];
        [aButton setBackgroundImage:[imagePressed stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] forState:UIControlStateSelected];
    }
}

+(void)setButton:(UIButton*)btn ImgName:(NSString*)imageNameN imP: (NSString *)imageNameP{
    UIImage *image = [UIImage imageNamed:imageNameN];
    UIImage *pressImage = [UIImage imageNamed:imageNameP];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:pressImage forState:UIControlStateHighlighted];
    [btn setImage:pressImage forState:UIControlStateSelected];
}

+(void)setButtonBackGroundImgName:(UIButton*)aButton imN: (NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *pressImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press.png",imageName]];
    pressImage = pressImage?pressImage:image;
    
    return [self setButtonWithStrethImg:aButton imgN:image imgP:pressImage edgeInsets:UIEdgeInsetsMake(5.0, 5.0,5.0, 5.0)];
}

// 热区和button大小不同的一种button 蓝色外边
+(void)SetButtonBorderBlue1:(UIButton *)button{
    UIImage *imageNormal =[UIImage imageNamed:@"btn_Outline"];
    [button setBackgroundImage:imageNormal forState:UIControlStateNormal];
    UIImage *imagePressed =[UIImage imageNamed:@"btn_Outline_press"];
    [button setBackgroundImage:imagePressed forState:UIControlStateHighlighted];
    [button setBackgroundImage:imagePressed forState:UIControlStateSelected];
}


// 热区和button 相同的一种button 蓝色外边
+(void)SetButtonBorderBlue2:(UIButton *)button{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(12.0, 12.0, 12.0, 12.0);
    UIImage *imageNormal = [UIImage imageNamed:@"btn_outline_blue"];
    UIImage *imagePressed = [UIImage imageNamed:@"btn_outline_blue_press"];
    [self setButtonWithStrethImg:button imgN:imageNormal imgP:imagePressed edgeInsets:edgeInsets];
}



// 左右两边拼接起来的两个 button 只设置点击后的图片 原始为白色

+(void)SetButtonImgLeftAndRight:(UIButton *)buttonL right:(UIButton *)buttonR{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(12.0, 12.0, 12.0, 12.0);
    UIImage *imagePressedL = [UIImage imageNamed:@"2btnL_press"];
    UIImage *imagePressedR = [UIImage imageNamed:@"2btnR_press"];
    if ([imagePressedL respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
        [buttonL setBackgroundImage:[imagePressedL resizableImageWithCapInsets:edgeInsets] forState:UIControlStateHighlighted];
        [buttonL setBackgroundImage:[imagePressedL resizableImageWithCapInsets:edgeInsets] forState:UIControlStateSelected];
        [buttonR setBackgroundImage:[imagePressedR resizableImageWithCapInsets:edgeInsets] forState:UIControlStateHighlighted];
        [buttonR setBackgroundImage:[imagePressedR resizableImageWithCapInsets:edgeInsets] forState:UIControlStateSelected];
    }
    else
    {
        [buttonL setBackgroundImage:[imagePressedL stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] forState:UIControlStateHighlighted];
        [buttonL setBackgroundImage:[imagePressedL stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] forState:UIControlStateSelected];
        [buttonR setBackgroundImage:[imagePressedR stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] forState:UIControlStateHighlighted];
        [buttonR setBackgroundImage:[imagePressedR stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] forState:UIControlStateSelected];
    }
}

// 给一个view加上下面的border 包括navigationbar  searchbar 默认为BorderColorGrey
+(void)AddBottomBorder:(UIView *)aview{
    [self AddBottomBorder:aview color:BorderColorGrey];
}

+(void)AddBottomBorderForNavBar:(UIView *)aview{
    [self AddBottomBorder:aview color:[UIColor colorWithRed:(167/255.0) green:(167/255.0) blue:(167/255.0) alpha:1]];
}

+(void)AddBottomBorder:(UIView *)aview color:(UIColor*)color{
    float linewidth = (1.0 / [UIScreen mainScreen].scale);
    UIView *border = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(aview.bounds) - linewidth, aview.frame.size.width,linewidth)];
    border.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    border.backgroundColor = color;
    [aview addSubview:border];
}

// 默认为BorderColorGrey
+(void)AddUpperBorder:(UIView *)aview{
    [self AddUpperBorder:aview color:BorderColorGrey];
}

+(void)AddUpperBorder:(UIView *)aview color:(UIColor*)color{
    float linewidth = (1.0 / [UIScreen mainScreen].scale);
    UIView *border = [[UIView alloc]initWithFrame:CGRectMake(0, 0, aview.frame.size.width,linewidth)];
    border.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    border.backgroundColor = color;
    [aview addSubview:border];
}

// 默认为BorderColorGrey1
+(void)AddUpperBorder:(UIView *)aview WithIndent:(int)indent{
    float linewidth = (1.0 / [UIScreen mainScreen].scale);
    UIView *border = [[UIView alloc]initWithFrame:CGRectMake(indent, 0, aview.frame.size.width,linewidth)];
    border.backgroundColor = BorderColorGreyInnerTable;
    [aview addSubview:border];
}

+(void)AddRightBorder:(UIView *)aview{
    float linewidth = (1.0 / [UIScreen mainScreen].scale);
    UIView *border = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(aview.bounds)-linewidth,0, linewidth,aview.frame.size.height)];
    border.backgroundColor = BorderColorGrey;
    [aview addSubview:border];
}

+(void)AddLeftBorder:(UIView *)aview{
    float linewidth = (1.0 / [UIScreen mainScreen].scale);
    UIView *border = [[UIView alloc]initWithFrame:CGRectMake(0,0, linewidth,aview.frame.size.height)];
    border.backgroundColor = BorderColorGrey;
    [aview addSubview:border];
}

//给一个view加上border 一般是button （在bar上）没有圆角 灰色
+(void)AddBorderForView:(UIView *)aview{
    float linewidth = (1.0 / [UIScreen mainScreen].scale);
    aview.layer.borderColor = LineAndBorderGray.CGColor;
    aview.layer.borderWidth = linewidth;
}


//给一个view加上border  有圆角 蓝色
+(void)AddGreenBorderForView:(UIView *)aview{
    float linewidth = (1.0);
    aview.layer.borderColor = WordColorBlue1.CGColor;
    aview.layer.borderWidth = linewidth;
    aview.layer.cornerRadius = 3; 
} 


//给一个label 配置字体stheiti 颜色黑色 大小19  用于navbar等
+(void)SetLabelForTitleBlack19:(UILabel *)alabel{
    alabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19];
    alabel.textColor = TitleColorBlack;
}


+(void)formatNumLabelFont:(UILabel*)aLabel{
    aLabel.font = [self formatNumFontWithSize:aLabel.font.pointSize];
}

+(UIFont*)formatNumFontWithSize:(CGFloat)fontSize{
    UIFont *aFont;
    if ((floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)) { // ios 7.0 and later
        aFont = [UIFont fontWithName:@"Din Alternate" size:fontSize];
    }
    else if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_6_0){ // 6.0 and later
        aFont = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:fontSize];
    }
    else{
        aFont = [UIFont systemFontOfSize:fontSize];
    }
    return aFont;
}

// 生成tablecell的背景颜色 这种table 是有 outter border的 即最外面的 border
+(void)formatBackGroundViewForTableWithOutterBorder:(UIView*)view countOfSection:(int)count currentPosition:(int)row {
    if(count == 1){
        [self AddUpperBorder:view];
        [self AddBottomBorder:view];
    }
    else{
        if (row == 0) {
            [self AddUpperBorder:view];
        }else if (row == count -1){
            [self AddUpperBorder:view color:BorderColorGreyInnerTable];
            [self AddBottomBorder:view];
        }else{
            [self AddUpperBorder:view color:BorderColorGreyInnerTable];
        }
    }
}

// 生成tablecell的背景颜色 这种table 是有 outter border的 但是内部sepetor有indent
+(void)formatBackGroundViewForTableWithOutterBorderAndIndent:(UIView*)view countOfSection:(int)count currentPosition:(int)row indent:(int)indent{
    if(count == 1){
        [self AddUpperBorder:view];
        [self AddBottomBorder:view];
    }
    else{
        if (row == 0) {
            [self AddUpperBorder:view];
        }else if (row == count -1){
            [self AddUpperBorder:view WithIndent:indent];
            [self AddBottomBorder:view];
        }else{
            [self AddUpperBorder:view WithIndent:indent];
        }
        
    }
}

// 生成tablecell的背景颜色 这种table 是有 outter border的 但是内部sepetor有indent
+(void)formatBackGroundViewForTableWithOutterBorderAndIndent:(UIView*)view countOfSection:(int)count currentPosition:(int)row Indent:(int)indent
{
    if(count == 1){
        [self AddUpperBorder:view];
        [self AddBottomBorder:view];
    }
    else{
        if (row == 0) {
            [self AddUpperBorder:view];
        }else if (row == count -1){
            [self AddUpperBorder:view WithIndent:indent];
            [self AddBottomBorder:view];
        }else{
            [self AddUpperBorder:view WithIndent:indent];
        }
        
    }
}


+(void)formatBackGroundViewForTableNoOutterBorderAndIndent:(UIView*)view countOfSection:(int)count currentPosition:(int)row indent:(int)indent
{
    if(row != 0)
    {
        [self AddUpperBorder:view WithIndent:indent];
    }
}


// 生成tablecell的背景颜色 这种table 是无 outter border的
+(void)formatBackGroundViewForTableNoOutterBorder:(UIView*)view countOfSection:(int)count currentPosition:(int)row {
    if(row != 0)
    {
        [self AddUpperBorder:view];
    }
}

+(void)formatCellBackgroundRound:(UITableViewCell*)cell height:(int)height countOfSection:(int)count currentPosition:(int)row type:(TableViewCellType)type{
    [self formatCellBackgroundRound:cell height:height countOfSection:count currentPosition:row type:type indent:0];
}

+(void)formatCellBackgroundRound:(UITableViewCell*)cell height:(int)height countOfSection:(int)count currentPosition:(int)row type:(TableViewCellType)type indent:(int)indent{
    UIView *backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, height)];
    UIView *selectedBackgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, height)];
    
    switch (type) {
        case TableViewCellTypeNormalWithOutterBorder:
            backgroundView.backgroundColor = ViewBackGroundColorWhilte;
            selectedBackgroundView.backgroundColor = TableCellSelectColor;
            
            [self formatBackGroundViewForTableWithOutterBorder:backgroundView countOfSection:count currentPosition:row];
            [self formatBackGroundViewForTableWithOutterBorder:selectedBackgroundView countOfSection:count currentPosition:row];
            break;
            
        case TableViewCellTypeNormalNoOutterBorder:
            backgroundView.backgroundColor = ViewBackGroundColorWhilte;
            selectedBackgroundView.backgroundColor = TableCellSelectColor;
            
            [self formatBackGroundViewForTableNoOutterBorder:backgroundView countOfSection:count currentPosition:row];
            [self formatBackGroundViewForTableNoOutterBorder:selectedBackgroundView countOfSection:count currentPosition:row];
            break;
            
        case TableViewCellTypeNormalWithOutterBorderAndHasIndent:
            backgroundView.backgroundColor = ViewBackGroundColorWhilte;
            selectedBackgroundView.backgroundColor = TableCellSelectColor;
            
            [self formatBackGroundViewForTableWithOutterBorderAndIndent:backgroundView countOfSection:count currentPosition:row indent:indent];
            [self formatBackGroundViewForTableWithOutterBorderAndIndent:selectedBackgroundView countOfSection:count currentPosition:row indent:indent];
            break;
        case TableViewCellTypeNormalNoOutterBorderAndHasIndent:
            backgroundView.backgroundColor = ViewBackGroundColorWhilte;
            selectedBackgroundView.backgroundColor = TableCellSelectColor;
            
            [self formatBackGroundViewForTableNoOutterBorderAndIndent:backgroundView countOfSection:count currentPosition:row indent:indent];
            [self formatBackGroundViewForTableNoOutterBorderAndIndent:selectedBackgroundView countOfSection:count currentPosition:row indent:indent];
            break;
        default:
            break;
    }
    
    cell.backgroundView = backgroundView;
    cell.selectedBackgroundView = selectedBackgroundView;
}


+ (void)formatButton:(UIButton*)button type:(LBButtonType)type{
    switch (type) {
        case LBButtonTypeWhite:
        {
            [self formatButton:button color:[UIColor whiteColor] pressColor:ColorBorderButtonGray];
            button.layer.cornerRadius =  ButtonBorderRadius;
            button.layer.borderWidth = 1/[UIScreen mainScreen].scale;
            button.layer.borderColor = ColorButtonGrayOpaue.CGColor;
            button.clipsToBounds = YES;
        }
            break;
        case LBButtonTypeClear:
        {
            [self formatButton:button color:[UIColor clearColor] pressColor:TableCellSelectColor];
        }
            break;
        case LBButtonTypeBlue:
        {
            [self formatButton:button color:ColorLBBlue pressColor:ColorLBBlueDark];
            button.layer.cornerRadius =  ButtonBorderRadius;
            button.clipsToBounds = YES;
        }
            break;
        case LBButtonTypeRed:
        {
            [self formatButton:button color:ColorLBRed pressColor:ColorLBRedDark];
            button.layer.cornerRadius =  ButtonBorderRadius;
            button.clipsToBounds = YES;
        }
            break;
        case LBButtonTypeYellow:
        {
            [self formatButton:button color:ColorLBYellow pressColor:ColorLBYellowDark];
            button.layer.cornerRadius =  ButtonBorderRadius;
            button.clipsToBounds = YES;
        }
            break;
        case LBButtonTypeBlack:
        {
            [self formatButton:button color:[UIColor whiteColor] pressColor:BlackColorWithAlpha(0.15)];
            button.layer.cornerRadius =  ButtonBorderRadius;
            button.layer.borderWidth = 1/[UIScreen mainScreen].scale;
            button.layer.borderColor = BlackColorWithAlpha(0.15).CGColor;
            button.clipsToBounds = YES;
        }
            break;
    }
    [button.titleLabel setShadowColor:[UIColor clearColor]];
}


+ (void)formatButton:(UIButton*)button color:(UIColor*)color pressColor:(UIColor*)pcolor{
    [button setBackgroundImage:[self imageWithColor:color] forState:UIControlStateNormal];
    UIImage *Img = [self imageWithColor:pcolor];
    [button setBackgroundImage:Img forState:UIControlStateHighlighted];
    [button setBackgroundImage:Img forState:UIControlStateSelected];
}

//根据六位十六进制RGB数，返回一个UIColor
+ (UIColor *)colorWithRGBString:(NSString *)colorString {
    NSString *rString = [colorString substringWithRange:NSMakeRange(0, 2)];
    NSInteger r = [self hexaToDecimal:rString];
    NSString *gString = [colorString substringWithRange:NSMakeRange(2, 2)];
    NSInteger g = [self hexaToDecimal:gString];
    NSString *bString = [colorString substringWithRange:NSMakeRange(4, 2)];
    NSInteger b = [self hexaToDecimal:bString];
    CGFloat div = 255.0f;
    return [UIColor colorWithRed:r/div green:g/div blue:b/div alpha:1.0f];
}

+ (NSInteger)hexaToDecimal:(NSString *)string {
    NSInteger decimal = 0;
    for (NSInteger i = 0; i < string.length; i++) {
        char c = [string characterAtIndex:i];
        NSInteger temp = 0;
        if (c >= '0' && c <= '9') {
            temp = c - '0';
        } else if (c >= 'a' && c <= 'f') {
            temp = c - 'a' + 10;
        } else if ((c >= 'A' && c<= 'F')) {
            temp = c - 'A' + 10;
        }
        decimal = temp + decimal * 16;
    }
    return decimal;
}



+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
