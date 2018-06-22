//
//  UIImage+JXGif.m
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "UIImage+JXGif.h"
#import "UIImage+GIF.h"

@implementation UIImage (JXGif)

+ (UIImage *)ac_setGifWithData: (NSData *)data {
    return [self sd_animatedGIFWithData:data];
}

+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle {
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:path ofType:type]];
}

@end
