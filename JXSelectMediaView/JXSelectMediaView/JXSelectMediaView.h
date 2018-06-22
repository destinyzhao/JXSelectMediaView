//
//  JXSelectMediaView.h
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXMediaModel.h"
#import "JXMediaManager.h"
#import "UIImage+JXGif.h"
#import "NSString+JXExtend.h"

typedef void(^JXMediaHeightBlock)(CGFloat mediaHeight);
typedef void(^JXAddMediaBlock)(void);
typedef void(^JXShowMediaBlock)(NSInteger index);
typedef void(^JXDeleteMediaBlock)(NSInteger index);

@interface JXSelectMediaView : UIView

/*** 可选择的最大资源数,（包括 preShowMedias 预先展示数据）. default is 9*/
@property (nonatomic, assign) NSInteger maxImageSelected;
/*** 是否需要显示添加按钮. Defaults is YES*/
@property (nonatomic, assign) BOOL showAddButton;
/*** 是否显示删除按钮. Defaults is YES*/
@property (nonatomic, assign) BOOL showDelete;
/** 一行显示图片个数. default is 4. */
@property (nonatomic, assign) NSInteger rowImageCount;
/** item行间距. default is 10. */
@property (nonatomic, assign) CGFloat lineSpacing;
/** item列间距. default is 10. */
@property (nonatomic, assign) CGFloat interitemSpacing;
/** section边距. default is (10, 10, 10, 10). */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 添加按钮的图片. 不想使用自带的图片可以自定义传入. */
@property (nonatomic, strong) UIImage *addImage;
/** 删除按钮的图片. 不想使用自带的图片可以自定义传入. */
@property (nonatomic, strong) UIImage *deleteImage;
/** 视频标签图片. 不想使用自带的图片可以自定义传入. */
@property (nonatomic, strong) UIImage *videoTagImage;
/** 图片底层视图的背景色 */
@property (nonatomic, strong) UIColor *backgroundColor;
/** 总的媒体数组 */
@property (nonatomic, strong) NSMutableArray *mediaArray;

/**
 * 监控view的高度变化，如果不和其他控件一起使用，则可以不用监控高度变化
 */
- (void)observeViewHeight:(JXMediaHeightBlock)value addMedia:(JXAddMediaBlock)addMedia showMedia:(JXShowMediaBlock)showMedia deleteMedia:(JXDeleteMediaBlock)deleteMedia;

@end
