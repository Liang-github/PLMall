//
//  PLSpeedy.h
//  
//
//  Created by PengLiang on 2017/8/4.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PLSpeedy : NSObject
/*
 设置按钮的圆角
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+ (id)pl_changeControlCircularWith:(id)anyControl andSetCornerRadius:(NSInteger)radius setBorderWidth:(NSInteger)width setBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can;
/*
 选取部分数据变色（label）
 @param label label
 @param array 变色数组
 @param color 变色颜色
 @return label
 */
+ (id)pl_setSomeOneChangeColor:(UILabel *)label setSelectArray:(NSArray *)array setChangeColor:(UIColor *)color;

#pragma mark - 根据传入字体大小计算字体宽高
+ (CGSize)pl_calculateTextSizeWithText:(NSString *)text withTextFont:(NSInteger)textFont withMaxW:(CGFloat)maxW;

/*
 下划线
 @param view 下划线
 */
+ (void)pl_setUpAcrossPartingLineWith:(UIView *)view withColor:(UIColor *)color;
/*
 竖划线
 @param view 竖划线
 */
+ (void)pl_setUpLongLineWith:(UIView *)view withColor:(UIColor *)color withHightRatio:(CGFloat)ratio;
/*
 利用贝塞尔曲线设置圆角
 @param control 按钮
 @param size 圆角尺寸
 */
+ (void)pl_setUpBezierPathCircularLayerWith:(id)control withSize:(CGSize)size;
/*
 label首行缩进
 @param label label
 @param emptylen 缩进比
 */
+ (void)pl_setUpLabel:(UILabel *)label content:(NSString *)content indentationFortheFirstLineWith:(CGFloat)emptylen;
/*
 字符串加星处理
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)pl_encryptionDisplayMessageWith:(NSString *)content withFirstIndex:(NSInteger)findex;
#pragma mark - 图片转base64编码
+ (NSString *)imageToBase64Str:(UIImage *)image;
#pragma mark - base64编码转图片
+ (UIImage *)base64StrToImage:(NSString *)encodedImageStr;
@end
