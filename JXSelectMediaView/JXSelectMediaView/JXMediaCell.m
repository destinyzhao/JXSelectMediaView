//
//  JXMediaCell.m
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "JXMediaCell.h"
#import "UIImageView+JXMediaExtend.h"

static CGFloat kDeleteButtonWidth = 20.;

@interface JXMediaCell ()

///图片
@property (nonatomic, strong) UIImageView *icon;

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

/** 视频标志 */
@property (nonatomic, strong) UIImageView *videoImageView;

@end

@implementation JXMediaCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _icon = [[UIImageView alloc] init];
    _icon.clipsToBounds = YES;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_icon];
    
    _deleteButton = [[UIButton alloc] init];
    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"media_delete"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteButton];
    
    _videoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"media_video"]];
    [self.contentView addSubview:_videoImageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _icon.frame = self.bounds;
    _deleteButton.frame = CGRectMake(self.bounds.size.width - kDeleteButtonWidth, 0, kDeleteButtonWidth, kDeleteButtonWidth);
    _videoImageView.frame = CGRectMake(self.bounds.size.width/4, self.bounds.size.width/4, self.bounds.size.width/2, self.bounds.size.width/2);
}

#pragma mark - public methods

- (void)showAddWithImage: (UIImage *)addImage
{
    if (addImage) {
        self.icon.image = addImage;
    }else {
        self.icon.image = [UIImage imageNamed:@"media_add"];
    }
    self.deleteButton.hidden = YES;
    self.videoImageView.hidden = YES;
}

- (void)showIconWithUrlString: (NSString *)urlString image: (UIImage *)image
{
    if (urlString){
        [self.icon jx_setImageWithUrlString:urlString placeholderImage:nil];
    }else if (image){
        self.icon.image = image;
    }
    self.videoImageView.hidden = YES;
    self.deleteButton.hidden = NO;
}

- (void)deleteButtonWithImage: (UIImage *)deleteImage show: (BOOL)show
{
    if (deleteImage) {
        [self.deleteButton setBackgroundImage:deleteImage forState:UIControlStateNormal];
    }
    self.deleteButton.hidden = !show;
}

- (void)videoImage: (UIImage *)videoImage show: (BOOL)show
{
    if (videoImage) {
        self.videoImageView.image = videoImage;
    }
    self.videoImageView.hidden = !show;
}

- (void)clickDeleteButton {
    !_JXMediaClickDeleteBlock ?  : _JXMediaClickDeleteBlock();
}

@end
