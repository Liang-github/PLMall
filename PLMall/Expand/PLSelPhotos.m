//
//  PLSelPhotos.m
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLSelPhotos.h"

@interface PLSelPhotos ()
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@end
@implementation PLSelPhotos
+ (instancetype)selPhotos {
    return [[self alloc] init];
}
#pragma mark - 已选择的图片
- (NSMutableArray *)selectedPhotos {
    if (!_selectedPhotos) {
        _selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}
- (NSMutableArray *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray array];
    }
    return _selectedAssets;
}
#pragma mark - TZImagePickerController
- (void)pushImagePickerControllerWithImagesCount:(NSInteger)imagesCount withColumnNumber:(NSInteger)columnNumber didFinish:(void (^)(TZImagePickerController *))complete {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:imagesCount columnNumber:columnNumber delegate:nil];
    imagePickerVc.selectedAssets = self.selectedAssets; //目前已经选中的图片数组
    imagePickerVc.allowTakePicture = NO; //在内部不显示拍照按钮
    //设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    //照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    !complete ? : complete(imagePickerVc);
}
#pragma mark - 照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转化的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *imagePath = [[NSString alloc] initWithFormat:@"/headImage.png"];
    [fileManager createFileAtPath:[documentsPath stringByAppendingString:imagePath] contents:data attributes:nil];
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@",documentsPath,imagePath];
    return filePath;
}
@end
