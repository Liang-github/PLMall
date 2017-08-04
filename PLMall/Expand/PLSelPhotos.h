//
//  PLSelPhotos.h
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TZImagePickerController.h>
#import <TZImageManager.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface PLSelPhotos : NSObject

//初始化
+ (instancetype)selPhotos;
/*
 跳转到选择照片控制器
 @param imagesCount 选择的照片张数
 @param columnNumber 选择界面每行显示几张照片
 @param complete 选择完成回调
 */
- (void)pushImagePickerControllerWithImagesCount:(NSInteger)imagesCount withColumnNumber:(NSInteger)columnNumber didFinish:(void(^)(TZImagePickerController *imagePickerVc))complete;
@end
