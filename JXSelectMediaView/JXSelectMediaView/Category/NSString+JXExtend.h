//
//  NSString+JXExtend.h
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JXExtend)

/**
 判断该字符串是不是一个有效的URL
 
 @return YES：是一个有效的URL or NO
 */
- (BOOL)isValidUrl;

/** 根据图片名 判断是否是gif图 */
- (BOOL)isGifImage;

/** 根据图片data 判断是否是gif图 */
+ (BOOL)isGifWithImageData: (NSData *)data;

/**
 根据image的data 判断图片类型
 
 @param data 图片data
 @return 图片类型(png、jpg...)
 */
+ (NSString *)contentTypeWithImageData: (NSData *)data;

@end
