//
//  UIImageView+JXMediaExtend.m
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "UIImageView+JXMediaExtend.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (JXMediaExtend)

- (void)jx_setImageWithUrlString:(NSString *)urlString placeholderImage: (UIImage *)placeholderImage {
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage];
}

@end
