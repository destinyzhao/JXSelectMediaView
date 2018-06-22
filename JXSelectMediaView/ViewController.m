//
//  ViewController.m
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "ViewController.h"
#import "JXSelectMediaView.h"
#import "TZImagePickerController.h"

// 最多展示照片数量
const NSInteger kMaxShowPhoto = 18;
// 每次最多选中照片数量
const NSInteger kSelectedMaxPhoto = 6;

@interface ViewController ()<TZImagePickerControllerDelegate>

@property (strong, nonatomic) JXSelectMediaView *mediaView;
@property (strong, nonatomic) NSMutableArray *selectedMediaArr;
@property (strong, nonatomic) NSMutableArray *selectedAssetArr;

@end

@implementation ViewController

- (NSMutableArray *)selectedMediaArr
{
    if (!_selectedMediaArr) {
        _selectedMediaArr = [NSMutableArray array];
    }
    return _selectedMediaArr;
}

- (NSMutableArray *)selectedAssetArr
{
    if (!_selectedAssetArr) {
        _selectedAssetArr = [NSMutableArray array];
    }
    return _selectedAssetArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupSelectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSelectView
{
    JXSelectMediaView *mediaView = [[JXSelectMediaView alloc] initWithFrame:CGRectMake(0, 150, [[UIScreen mainScreen] bounds].size.width, 1)];
    mediaView.maxImageSelected = kMaxShowPhoto;
    mediaView.rowImageCount = 4;
    mediaView.lineSpacing = 5;
    mediaView.interitemSpacing = 5;
    mediaView.backgroundColor = [UIColor grayColor];
    [mediaView observeViewHeight:^(CGFloat mediaHeight) {
        CGRect frame = mediaView.frame;
        frame.size.height =  mediaHeight + 40;
        mediaView.frame = frame;
    } addMedia:^{
        [self addMedia];
    } showMedia:^(NSInteger index) {
        
    } deleteMedia:^(NSInteger index) {
        [self deleteMedia:index];
    }];
    // observeViewHeight 存在时可以不写
    //    [mediaView reload];
    self.mediaView = mediaView;
    [self.view addSubview:mediaView];
}

- (void)addMedia
{
    // 最多选中照片数量
    NSInteger max = kMaxShowPhoto - self.selectedMediaArr.count > kSelectedMaxPhoto?kSelectedMaxPhoto:kMaxShowPhoto - self.selectedMediaArr.count;

     TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:max columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.showPhotoCannotSelectLayer = YES; // 是否显示蒙板
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8]; //蒙板颜色
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.showSelectedIndex = YES; // 选中照片右下角显示数字
    imagePickerVc.allowPickingOriginalPhoto = YES; // 是否显示原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)deleteMedia:(NSInteger)index
{
    [self.selectedMediaArr removeObjectAtIndex:index];
    [self.mediaView setMediaArray:self.selectedMediaArr];
}

#pragma mark - TZImagePickerController Delegate

//相册选取图片
- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [self handleAssetsFromAlbum:assets photos:photos];
}

/** 从相册中选择图片之后的数据处理 */
- (void)handleAssetsFromAlbum: (NSArray *)assets photos: (NSArray *)photos
{
  
    for (PHAsset *new in assets) {
        NSInteger index = [assets indexOfObject:new];

        [[JXMediaManager manager] getMediaInfoFromAsset:new completion:^(NSString *name, id pathData) {
            
            JXMediaModel *model = [[JXMediaModel alloc] init];
            model.name = name;
            model.asset = new;
            model.uploadType = pathData;
            model.image = photos[index];
            [self.selectedMediaArr addObject:model];
            [self.selectedAssetArr addObject:new];
            
            if ([NSString isGifWithImageData:pathData]) {
                model.image = [UIImage ac_setGifWithData:pathData];
            }
            
            //最后一个处理完就在主线程中进行布局
            if ([new isEqual:[assets lastObject]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mediaView setMediaArray:self.selectedMediaArr];
                });
            }
            
        }];
       
    }
}

@end
