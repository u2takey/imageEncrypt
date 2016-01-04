//
//  RootViewController.h
//  pictureProcess
//
//  Created by Ibokan on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"
#import "UIImage+Resize.h"

@implementation ImageUtil

#define DefaultH (720.0)
#define DefaultKeyFactor (8)



static CGContextRef CreateRGBABitmapContext (CGImageRef inImage)// 返回一个使用RGBA通道的位图上下文
{
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData; //内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
    int bitmapByteCount;
    int bitmapBytesPerRow;
    
    size_t pixelsWide = CGImageGetWidth(inImage); //获取横向的像素点的个数
    size_t pixelsHigh = CGImageGetHeight(inImage); //纵向
    
    bitmapBytesPerRow	= (pixelsWide * 4); //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit(0-255)的空间
    bitmapByteCount	= (bitmapBytesPerRow * pixelsHigh); //计算整张图占用的字节数
    
    colorSpace = CGColorSpaceCreateDeviceRGB();//创建依赖于设备的RGB通道
    
    bitmapData = malloc(bitmapByteCount); //分配足够容纳图片字节数的内存空间
    
    context = CGBitmapContextCreate (bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    //创建CoreGraphic的图形上下文，该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数
    
    CGColorSpaceRelease( colorSpace );
    //Core Foundation中通过含有Create、Alloc的方法名字创建的指针，需要使用CFRelease()函数释放
    
    return context;
}

static unsigned char *RequestImagePixelData(UIImage *inImage)
// 返回一个指针，该指针指向一个数组，数组中的每四个元素都是图像上的一个像素点的RGBA的数值(0-255)，用无符号的char是因为它正好的取值范围就是0-255
{
    CGImageRef img = [inImage CGImage];
    CGSize size = [inImage size];
    
    CGContextRef cgctx = CreateRGBABitmapContext(img); //使用上面的函数创建上下文
    
    CGRect rect = {{0,0},{size.width, size.height}};
    
    CGContextDrawImage(cgctx, rect, img); //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
    unsigned char *data = CGBitmapContextGetData (cgctx);
    
    CGContextRelease(cgctx);//释放上面的函数创建的上下文
    return data;
}


+ (UIImage*)imageWithImageCode:(UIImage*)inImage key:(char*)keyData
{
    UIImage *_inImage = [inImage fixrotation];
    
    CGImageRef inImageRef = [_inImage CGImage];
    size_t w = CGImageGetWidth(inImageRef);
    size_t h = CGImageGetHeight(inImageRef);
    
    float scale = 0;
    if (h>w) {
        scale = DefaultH/h;
    }else{
        scale = DefaultH/w;
    }
    
    w = w * scale;
    h = h * scale;
    
    
    UIImage *img = [_inImage resizedImageToSize:CGSizeMake(floorf(_inImage.size.width*scale),floorf( _inImage.size.height*scale)) /*scaleIfSmaller:NO*/];
    
//    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(img.CGImage));
    unsigned char * imgPixel =  RequestImagePixelData(img);//CFDataGetBytePtr(data);
    
    NSLog(@"%zu %zu %zu %zu %ld %f %zu %zu",CGImageGetWidth(inImageRef),CGImageGetHeight(inImageRef),CGImageGetWidth(img.CGImage),CGImageGetHeight(img.CGImage),[img imageOrientation] ,scale ,w,h);
    
    unsigned char *resutlImgPixel1 = malloc(w * h * 4);
    unsigned char *resutlImgPixel2 = malloc(w * h * 4);
    
    
    //x trans
    size_t pixOff = 0;
    size_t newOff = 0;
    int key = 0;
    size_t newx = 0;
    
    for(GLuint y = 0;y< h;y++)//双层循环按照长宽的像素个数迭代每个像素点
    {
        for (GLuint x = 0; x<w; x++)
        {
            key = (unsigned char)keyData[y/DefaultKeyFactor];
            newx = (x + (key*DefaultKeyFactor))%w;
            pixOff = (w * y + x)*4;
            newOff = (w * y + newx)*4;
            resutlImgPixel1[newOff] = imgPixel[pixOff];
            resutlImgPixel1[newOff + 1] = imgPixel[pixOff+1];
            resutlImgPixel1[newOff + 2] = imgPixel[pixOff+2];
            resutlImgPixel1[newOff + 3] = imgPixel[pixOff +3];
        }
    }
    
    //y trans
    int newy = 0;
    
    for(GLuint y = 0;y< h;y++)//双层循环按照长宽的像素个数迭代每个像素点
    {
        for (GLuint x = 0; x<w; x++)
        {
            key = (unsigned char)keyData[x/DefaultKeyFactor];
            newy = (y + (key*DefaultKeyFactor))%h;
            pixOff = (w * y + x)*4;
            newOff = (w * newy + x)*4;
            resutlImgPixel2[newOff] = resutlImgPixel1[pixOff];
            resutlImgPixel2[newOff + 1] = resutlImgPixel1[pixOff + 1];
            resutlImgPixel2[newOff + 2] = resutlImgPixel1[pixOff + 2];
            resutlImgPixel2[newOff + 3] =  resutlImgPixel1[pixOff + 3];
        }
    }
    
    // code width and height
    NSInteger dataLength = w * h* 4;
    
    //下面的代码创建要输出的图像的相关参数
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, resutlImgPixel2, dataLength, NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    size_t bytesPerRow = 4 * w;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    
    CGImageRef imageRef = CGImageCreate(w, h , bitsPerComponent, bitsPerPixel, bytesPerRow,colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);//创建要输出的图像
    
    UIImage *myImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:_inImage.imageOrientation];
    
    CFRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    
    free(imgPixel);
    free(resutlImgPixel1);
 
    return myImage;
}

static int factor = 1;

+ (UIImage*)imageWithImageDecode:(UIImage*)inImage key:(char*)keyData
{
    UIImage *_inImage = [UIImage imageWithCGImage:inImage.CGImage scale:1.0 orientation:UIImageOrientationUp];
    
    //CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(inImage.CGImage));
    
    
    CGImageRef inImageRef = [_inImage CGImage];
    size_t w = CGImageGetWidth(inImageRef);
    size_t h = CGImageGetHeight(inImageRef);
    
    
    size_t oldh = 0;
    float scale = 0;
    size_t oldw = 0;
    
    if (h>w) {
        oldh = DefaultH * factor;
        scale = h*1.0/oldh;
    }else{
        oldw = DefaultH * factor;
        scale = w*1.0/oldw;
    }
    oldw = w / scale;
    oldh = h / scale;
    
    
    UIImage *img = [_inImage resizedImageToSize:CGSizeMake(oldw,oldh)];
    //CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(inImage.CGImage));
    unsigned char * imgPixel =  RequestImagePixelData(img);//CFDataGetBytePtr(data);
    
    NSLog(@"%zu %zu %ld %f %zu %zu",CGImageGetWidth(_inImage.CGImage),CGImageGetHeight(_inImage.CGImage),[_inImage imageOrientation] ,scale,oldw,oldh);
    
    unsigned char *resutlImgPixel1 = malloc(oldw*oldh*4);
    unsigned char *resutlImgPixel2 = malloc(oldw*oldh*4);
    
    h = oldh;
    w= oldw;
    
    //y trans
    size_t pixOff = 0;
    size_t newOff = 0;
    long key = 0;
    size_t newx = 0;
    size_t newy = 0;
    
    for(GLuint y = 0;y< h;y++)//双层循环按照长宽的像素个数迭代每个像素点
    {
        for (GLuint x = 0; x<w; x++)
        {
            key = (unsigned char)keyData[x/DefaultKeyFactor];
            newy = (y + ((h - key)*DefaultKeyFactor))%h;
            pixOff = (w * y  + x )*4;
            newOff = (w * newy + x)*4;
            
            resutlImgPixel1[newOff] =  imgPixel[pixOff];
            resutlImgPixel1[newOff + 1] =  imgPixel[ pixOff + 1];
            resutlImgPixel1[newOff + 2] =  imgPixel[ pixOff + 2];
            resutlImgPixel1[newOff + 3] =  imgPixel[ pixOff + 3];
        }
    }
    
    
    //x trans
    
    for(GLuint y = 0;y< h;y++)//双层循环按照长宽的像素个数迭代每个像素点
    {
        for (GLuint x = 0; x<w; x++)
        {
            key = (unsigned char)keyData[y/DefaultKeyFactor];
            newx = (x + ((w - key)*DefaultKeyFactor)) % w;
            pixOff = (w * y  + x )*4;
            newOff = (w * y + newx)*4;
            
            resutlImgPixel2[newOff] = resutlImgPixel1[pixOff];
            resutlImgPixel2[newOff + 1] = resutlImgPixel1[pixOff+1];
            resutlImgPixel2[newOff + 2] = resutlImgPixel1[pixOff +2];
            resutlImgPixel2[newOff + 3] = resutlImgPixel1[pixOff +3];
            
        }
    }
    
    
    
    NSInteger dataLength = w * h * 4;
    
    //下面的代码创建要输出的图像的相关参数
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, resutlImgPixel2, dataLength, NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    size_t bytesPerRow = 4 * w;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    
    CGImageRef imageRef = CGImageCreate(w, h, bitsPerComponent, bitsPerPixel, bytesPerRow,colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);//创建要输出的图像
    
    UIImage *myImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:_inImage.imageOrientation];
    
    CFRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    
    free(imgPixel);
    free(resutlImgPixel1);
    
    return myImage;
}


@end
