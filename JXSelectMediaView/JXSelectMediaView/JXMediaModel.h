//
//  JXMediaModel.h
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface JXMediaModel : NSObject

/** 媒体名字 */
@property (nonatomic, copy) NSString *name;
/** 媒体照片 */
@property (nonatomic, strong) UIImage *image;
/** url string image */
@property (nonatomic, copy) NSString *imageUrlString;
/** iOS8 之后的媒体属性 */
@property (nonatomic, strong) PHAsset *asset;
/** 媒体上传格式 图片是NSData，视频主要是路径名，也有NSData */
@property (nonatomic, strong) id uploadType;
/** 是否属于可播放的视频类型 */
@property (nonatomic, assign) BOOL isVideo;
/** 视频的URL */
@property (nonatomic, strong) NSURL *mediaURL;

@end
