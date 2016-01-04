//
//  QMUiUtis.h
//  SOSOMap
//
//  Created by leiiwang on 14-6-6.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * @brief 存放所有UI相关的常数,保持全局统一的UI风格 包括颜色、字体、布局、全局用的文案
 */




@interface QMUIUtis : NSObject

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark- for 3.0   结构按照3.0设计规范
////////////////////////////////////////////////////////////////////////////////////////////////
//1.字体
#pragma mark- 字体

#define UIChineseLightFont(value)  [UIFont fontWithName:@"STHeitiSC-Light" size:value]
#define UIChineseMediumFont(value)  [UIFont fontWithName:@"STHeitiSC-Medium" size:value]

#define UIEnglishLightFont(value)  [UIFont fontWithName:@"HelveticaNeue-Light" size:value]    //英文，数字
#define UIEnglishMediumFont(value)  [UIFont fontWithName:@"HelveticaNeue-Medium" size:value]

//2.图标

#pragma mark- 图标

//3.颜色

#pragma mark- 颜色

#define ColorLBBlue [UIColor colorWithRed:(0x00/255.0) green:(0x7b/255.0) blue:(0xf9/255.0) alpha:1]//路宝蓝
#define ColorLBBlueDark [UIColor colorWithRed:(0x00/255.0) green:(0x62/255.0) blue:(0xc7/255.0) alpha:1]

#define ColorLBRed [UIColor colorWithRed:(0x7b/255.0) green:(0x00/255.0) blue:(0xf9/255.0) alpha:1]//路宝 
#define ColorLBRedDark [UIColor colorWithRed:(0x62/255.0) green:(0x00/255.0) blue:(0xc7/255.0) alpha:1]

#define ColorLBYellow [UIColor colorWithRed:(0x7b/255.0) green:(0xf9/255.0) blue:(0x00/255.0) alpha:1]//路宝蓝
#define ColorLBYellowDark [UIColor colorWithRed:(0x62/255.0) green:(0xc7/255.0) blue:(0x00/255.0) alpha:1]


#define ColorBlueHighlighted [UIColor colorWithRed:(0x00/255.0) green:(0x62/255.0) blue:(0xc7/255.0) alpha:1]//点击蓝色按钮后的背景颜色
#define TitleColorBlack [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:0.9]//3.0 Navigation title颜色
#define RightTitleColorBlue [UIColor colorWithRed:(0x4c/255.0) green:(0xa2/255.0) blue:(0xfb/255.0) alpha:1]//导航栏右按钮点击后颜色
#define WordColorGrey [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:0.7] //3.0 title gray

#define ColorBackGround  [UIColor colorWithRed:(0xf0/255.0) green:(0xf0/255.0) blue:(0xf0/255.0) alpha:1]//3.0视觉背景色
#define ColorBackGroundDrakOpaque  [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:0.5]//3.0视觉半透明呢浮层颜色色
#define BorderColorGrey  [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:0.15] //border颜色灰色 也用于列表外部
#define BorderColorGreyInnerTable  [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:0.10] //border颜色灰色 也用于列表内部
#define ViewBackGroundColorWhilte [UIColor colorWithRed:(0xff/255.0) green:(0xff/255.0) blue:(0xff/255.0) alpha:1]////全局view使用的背景色 白色 一般用作前景色

#define BarBackGroundColorWhite ViewBackGroundColorWhilte 
#define ViewBackGroundColor ColorBackGround 

#define BlackColorWithAlpha(a) [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:a]  //3.0 浅黑色

#define BigLabelColorBlack BlackColorWithAlpha(0.9)   //3.0 好多的大label颜色
#define SmallLabelColorBlack BlackColorWithAlpha(0.7) //3.0 好多的小label颜色

//随车听
#define PauseOrFailColor UIColorFromHEX(0xd62a2f)
#define NormalColor UIColorFromHEX(0x0f0f0f)

//4.列表

#pragma mark- 列表
/**
 * @brief  格式化cell;所有的tablecell 目前有三种式样 1.有外边框 2.无外边框的 3. 内部有indent 的  cell白色 选择态 灰色 修改自 qmtableView 以后逐渐废弃 qmtableview
 *
 * @param  cell 待格式化的cell
 * @param  height  当前cell的高度 rowheight
 * @param  countOfSection 当前cell所在的section的列数目 rowcount in current section
 * @param  currentPosition 当前cell在section中的位置 row in current section
 * @param  type  类型选择 注释见 TableViewCellType
 *
 * @return nil
 */

#define TableRowHeightSingleline 56
#define TableRowHeightMultiline 72
#define SectionHeadHeight 16 // table的sectionheader高度 有文字的
#define SectionHeadPadding 12 // table的sectionheader title 的起始坐标
#define SectionHeadHeightNoWord  8// table的sectionheader高度 有文字的


#define TableCellSelectColor   [UIColor colorWithRed:(0xf6/255.0) green:(0xf6/255.0) blue:(0xf6/255.0) alpha:1] //talbe cell 选择态颜色

typedef NS_ENUM(NSUInteger, TableViewCellType) {
    TableViewCellTypeNormalWithOutterBorder,            //一种最常用到tablecell  内部有seperator 有外边
    TableViewCellTypeNormalNoOutterBorder,              //一种内部有seperator 但是没有外边
    TableViewCellTypeNormalWithOutterBorderAndHasIndent,// 内部有seperator 有外边 但是内部的seperator是有indent的 类似ios7的默认table
    TableViewCellTypeNormalNoOutterBorderAndHasIndent,// 内部有seperator 有外边 但是内部的seperator是有indent的
};
+(void)formatCellBackgroundRound:(UITableViewCell*)cell height:(int)height countOfSection:(int)count currentPosition:(int)row type:(TableViewCellType)type;
+(void)formatCellBackgroundRound:(UITableViewCell*)cell height:(int)height countOfSection:(int)count currentPosition:(int)row type:(TableViewCellType)type indent:(int)indent;
//5.标题栏格式
#pragma mark- 标题栏
#define kQMNavigationBarHeight 44



//6.tab样式
#pragma mark- tab样式
#define tab4BarHeight 48

//7.按钮样式
#pragma mark- 按钮样式

#define ColorBorderButtonGray [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:0.15]//button 的border颜色
#define ButtonBorderRadius (3.0)
#define ColorButtonGrayOpaue [UIColor colorWithRed:(0x00/255.0) green:(0x00/255.0) blue:(0x00/255.0) alpha:0.15]//button一种按下态颜色

typedef NS_ENUM(NSUInteger, LBButtonType) {
    LBButtonTypeWhite,            //一种白色button 点击态gray 有border
    LBButtonTypeClear,           //一种透明button 点击态TableCellSelectColor 无border
    LBButtonTypeBlue,
    LBButtonTypeRed,
    LBButtonTypeYellow,
    LBButtonTypeBlack,          //导航结束 所用
    
};
+ (void)formatButton:(UIButton*)button type:(LBButtonType)type;
+ (void)formatButton:(UIButton*)button color:(UIColor*)color pressColor:(UIColor*)pcolor;

//8.其他
#pragma mark- 其他

+ (UIImage *)imageWithColor:(UIColor *)color;


////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark- 下面的不要用了 to be deprecated 要用 需要确认之后挪到 上面去

#pragma mark- text
#define NoLocationToast @"现在无法定位，一会再来试试吧"

#pragma mark- colors


//***********************************************************************************
//*  general 全局使用的颜色
//***********************************************************************************





#define BarBackGroundColorBlue1 [UIColor colorWithRed:(0xd9/255.0) green:(0xde/255.0) blue:(0xe4/255.0) alpha:1]//背景颜色蓝色
#define BarBackGroundColorBlue2(opacity) [UIColor colorWithRed:(0x31/255.0) green:(0x8c/255.0) blue:(0xe8/255.0) alpha:opacity]//背景颜色蓝色


#define BarBackGroundColor2 [UIColor colorWithRed:(0xf0/255.0) green:(0xf4/255.0) blue:(0xf6/255.0) alpha:1] //背景颜色灰色


#define WordColorBlue1 [UIColor colorWithRed:(0x31/255.0) green:(0x8c/255.0) blue:(0xe8/255.0) alpha:1] //文字颜色 蓝色1 深
#define WordColorBlue2 [UIColor colorWithRed:(0x26/255.0) green:(0x89/255.0) blue:(0xea/255.0) alpha:0.5] //文字颜色 蓝色2 浅 透明



#define LineAndBorderGray [UIColor colorWithRed:(0xd1/255.0) green:(0xd6/255.0) blue:(0xdc/255.0) alpha:1] // 用于分割线的灰色
#define LineAndBorderGray2 [UIColor colorWithRed:(0xd6/255.0) green:(0xdb/255.0) blue:(0xe0/255.0) alpha:1] // 用于分割线的灰色2
#define LineAndBorderGray3 [UIColor colorWithRed:(0xe3/255.0) green:(0xe6/255.0) blue:(0xee/255.0) alpha:1] // 用于分割线的灰色3


#define  TableSectionHeaderColor  [UIColor colorWithRed:(0xea/255.0) green:(0xee/255.0) blue:(0xf2/255.0) alpha:1]// talbe section header的颜色


#define BtnSelectedColorGray [UIColor colorWithRed:(0xef/255.0) green:(0xf5/255.0) blue:(0xf8/255.0) alpha:1] //一种btn选中太颜色 目前用在车牌选择页中

#define WordColorBlueComment [UIColor colorWithRed:0x08/255.0 green:0x7d/255.0 blue:0xd5/255.0 alpha:1.0]     //显示有用、没用、鲜花、礼物的Label颜色

#define UIColorFromHEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0] 



#define TitleFontXihei [UIFont fontWithName:@"Heiti SC" size:14.0]// 一种title使用的字体
#define TableHeaderFont  [UIFont fontWithName:@"Helvetica" size:17.0]// 一种tableheader的字体
#define TableTitleFontXihei [UIFont fontWithName:@"Heiti SC" size:17.0]//一种table中使用的字体
#define TableTitleFontHel [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]//用于数字的一种字体

//适配设计稿在iOS7下显示正常，iOS6看起来特别大的字体
#define AdoptedFontWithSize(_x) \
IOS6_OR_EARLIER ? \
[UIFont fontWithName:@"Heiti SC" size:_x] : \
[UIFont fontWithName:@"Din Alternate" size:_x]

#pragma mark- UI position and size

//***********************************************************************************
//*  位置配置
//***********************************************************************************

// tabbar 配置








#define TableHeightSingleLineNormal 48 
#define TableHeightSingleLine 56 //目前用在违章查询城市选择表中

#pragma mark- picture

//***********************************************************************************
//*  通用图片素材
//***********************************************************************************



// page control使用
#define pageControlInactiveImgName @"icon_Page.png"
#define pageControlActiveImgName @"icon_Page_active.png"

// 一种通用的圆角button 白色 无border
#define roundButtonCommonBackImage @"btn_white_noborder"
#define roundButtonCommonBackImagePress @"btn_white_noborder_press"


// 一种通用的圆角button 蓝色 无border
#define roundButtonBlueBackImage @"btn_blue_noborder"
#define roundButtonBlueBackImagePress @"btn_blue_noborder_press"


// 一种通用的圆角button 绿色 无border
#define roundButtonGreenBackImage @"btn_green_noborder"
#define roundButtonGreenBackImagePress @"btn_green_noborder_press"


#define kRadioPlaceHolerImageBlur [UIImage imageNamed:@"radio_playing_bg"]
#define kRadioPlaceHolerImageVerticle [UIImage imageNamed:@"radio_placeholder_ver"]
#define kRadioPlaceHolerImageRect [UIImage imageNamed:@"radio_placeholder_rect"]
#define kRadioPlaceHolerImageVerticleSmall [UIImage imageNamed:@"radio_placeholder_ver_s"]
#define kRadioPlaceHolerImageLanscape [UIImage imageNamed:@"radio_placeholder_lan"]
#define kRadioPlaceHolerImageCat [UIImage imageNamed:@"radio_ic_loading_cati"]


#pragma mark- UI decorator


//***********************************************************************************
//*  UI装饰函数 更新视觉时 新建函数 要删掉旧的 防止过度膨胀到 不可用的状态
//***********************************************************************************

#define setButtonBackGroundImgName(aButton,imgName) [QMUIUtis setButtonBackGroundImgName:aButton imN:imgName];
#define setImgViewWithStrethImg(imageView,imgName) [QMUIUtis setImgViewWithStrethImg:imageView imgName:imgName];
#define AddBorderForView(aView) [QMUIUtis AddBorderForView: aView];
#define AddGreenBorderForView(aView) [QMUIUtis AddGreenBorderForView: aView];
#define SetLabelForTitleBlack19(aLabel) [QMUIUtis SetLabelForTitleBlack19: aLabel];

#define AddBottomBorderForNavBar(aBar) [QMUIUtis AddBottomBorderForNavBar: aBar];
#define AddBottomBorder(aView) [QMUIUtis AddBottomBorder: aView];
#define AddUpperBorder(aView) [QMUIUtis AddUpperBorder: aView];
#define AddRightBorder(aView) [QMUIUtis AddRightBorder: aView];
#define AddLeftBorder(aView) [QMUIUtis AddLeftBorder: aView]

#define SetButtonImgLeftAndRight(buttonL,buttonR) [QMUIUtis SetButtonImgLeftAndRight:buttonL  right:buttonR];
#define SetButtonBorderBlue2(aView) [QMUIUtis SetButtonBorderBlue2: aView];
#define SetButtonBorderBlue1(aView) [QMUIUtis SetButtonBorderBlue1: aView];
#define setButtonWithStrethImg(aButton,imageNormal,imagePressed,edgeInsets) [QMUIUtis setButtonWithStrethImg:aButton  imgN:imageNormal imgP:imagePressed edgeInsets:edgeInsets];
#define formatNumLabelFont(aLabel) [QMUIUtis formatNumLabelFont:aLabel]
#define formatNumFontWithSize(fontSize) [QMUIUtis formatNumFontWithSize:fontSize]









// 给imgview设置 拉伸图片
+(void)setImgViewWithStrethImg:(UIImageView *)imageView imgName:(NSString *)imgName;
// 给button 设置拉伸图片
+(void)setButtonWithStrethImg:(UIButton *)aButton imgN: (UIImage *)imageNormal imgP: (UIImage*)imagePressed edgeInsets:(UIEdgeInsets) edgeInsets;
+(void)setButton:(UIButton*)btn ImgName:(NSString*)imageNameN imP: (NSString *)imageNameP;

// 给button 设置背景拉伸图片
+(void)setButtonBackGroundImgName:(UIButton*)aButton imN: (NSString *)imageName;

// 热区和button大小不同的一种button 蓝色外边
+(void)SetButtonBorderBlue1:(UIButton *)button;
// 热区和button 相同的一种button 蓝色外边
+(void)SetButtonBorderBlue2:(UIButton *)button;
// 左右两边拼接起来的两个 button 只设置点击后的图片 原始为白色
+(void)SetButtonImgLeftAndRight:(UIButton *)buttonL right:(UIButton *)buttonR;
// 给一个view加上下面的border 包括navigationbar  searchbar
//#warning todo 待整理 leiiwang
+(void)AddBottomBorder:(UIView *)aview;
+(void)AddBottomBorderForNavBar:(UIView *)aview;

// 给一个view加上上面的border cell
+(void)AddUpperBorder:(UIView *)aview;
//给一个view加上border 一般是button （在bar上）没有圆角 灰色
+(void)AddRightBorder:(UIView *)aview;
+(void)AddLeftBorder:(UIView *)aview;
+(void)AddBorderForView:(UIView *)aview;
//给一个view加上border  有圆角 蓝色
+(void)AddGreenBorderForView:(UIView *)aview;
//给一个label 配置字体stheiti 颜色WordColorBlack 大小18  用于navbar等
+(void)SetLabelForTitleBlack19:(UILabel *)alabel;
// 设置 numlabel的字体
+(void)formatNumLabelFont:(UILabel*)aLabel;
+(UIFont*)formatNumFontWithSize:(CGFloat)fontSize;


//传入十六进制颜色值表示的字符串，注意只传六位，没有做容错处理，大小写均可，如；@“FFFFFF”
+ (UIColor *)colorWithRGBString:(NSString *)colorString;

@end
