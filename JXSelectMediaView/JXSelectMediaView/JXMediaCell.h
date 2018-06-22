//
//  JXMediaCell.h
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXMediaCell : UICollectionViewCell

- (void)showAddWithImage: (UIImage *)addImage;

- (void)showIconWithUrlString: (NSString *)urlString image: (UIImage *)image;

- (void)deleteButtonWithImage: (UIImage *)deleteImage show: (BOOL)show;

- (void)videoImage: (UIImage *)videoImage show: (BOOL)show;

/** 点击删除按钮的回调block */
@property (nonatomic, copy) void(^JXMediaClickDeleteBlock)(void);


@end
