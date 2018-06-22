//
//  UIImage+JXGif.h
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JXGif)


/** 根据gif的data 设置image */
+ (UIImage *)ac_setGifWithData: (NSData *)data;

/**
 给 UIImage 设置bundle图片
 */
+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle;

@end
