//
//  UIImageView+JXMediaExtend.h
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JXMediaExtend)

- (void)jx_setImageWithUrlString: (NSString *)urlString placeholderImage: (UIImage *)placeholderImage;

@end
