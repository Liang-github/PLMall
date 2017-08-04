//
//  PLSpeedy.m
//  
//
//  Created by PengLiang on 2017/8/4.
//
//

#import "PLSpeedy.h"

@implementation PLSpeedy
+ (id)pl_changeControlCircularWith:(id)anyControl andSetCornerRadius:(NSInteger)radius setBorderWidth:(NSInteger)width setBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can {
    CALayer *icon_layer = [anyControl layer];
    [icon_layer setCornerRadius:radius];
    [icon_layer setBorderWidth:width];
    [icon_layer setBorderColor:[borderColor CGColor]];
    [icon_layer setMasksToBounds:can];
    return anyControl;
}
+ (id)pl_setSomeOneChangeColor:(UILabel *)label setSelectArray:(NSArray *)array setChangeColor:(UIColor *)color {
    if (label.text.length == 0) {
        return 0;
    }
    int i;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:label.text];
    for (i = 0; i < label.text.length; i ++) {
        NSString *a = [label.text substringWithRange:NSMakeRange(i, 1)];
        NSArray *number = array;
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributeString;
    return label;
}
#pragma mark - 根据传入字体大小计算字体宽高
+ (CGSize)pl_calculateTextSizeWithText:(NSString *)text withTextFont:(NSInteger)textFont withMaxW:(CGFloat)maxW {
    CGFloat textMaxW = maxW;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:PFR size:textFont]} context:nil].size;
    return textSize;
}
#pragma mark - 下划线
+ (void)pl_setUpAcrossPartingLineWith:(UIView *)view withColor:(UIColor *)color {
    UIView *cellAcrossPartingLine = [[UIView alloc] init];
    cellAcrossPartingLine.backgroundColor = color;
    [view addSubview:cellAcrossPartingLine];
    
    [cellAcrossPartingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.bottom.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(view.pl_width, 1));
    }];
}
#pragma mark - 竖线
+ (void)pl_setUpLongLineWith:(UIView *)view withColor:(UIColor *)color withHightRatio:(CGFloat)ratio {
    if (ratio == 0) { //默认1
        ratio = 1;
    }
    UIView *cellLongLine = [[UIView alloc] init];
    cellLongLine.backgroundColor = color;
    [view addSubview:cellLongLine];
    
    [cellLongLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(1, view.pl_height*ratio));
    }];
}
#pragma mark - 首行缩进
+ (void)pl_setUpLabel:(UILabel *)label content:(NSString *)content indentationFortheFirstLineWith:(CGFloat)emptylen {
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init]; //首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    label.attributedText = attrText;
}
#pragma mark - 设置圆角
+ (void)pl_setUpBezierPathCircularLayerWith:(UIButton *)control withSize:(CGSize)size {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:control.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = control.bounds;
    maskLayer.path = maskPath.CGPath;
    control.layer.mask = maskLayer;
}
#pragma mark - 字符串加星处理
+ (NSString *)pl_encryptionDisplayMessageWith:(NSString *)content withFirstIndex:(NSInteger)findex {
    if (findex <= 0) {
        findex = 2;
    } else if (findex + 1 > content.length) {
        findex --;
    }
    return [NSString stringWithFormat:@"%@***%@",[content substringToIndex:findex],[content substringFromIndex:content.length - 1]];
}
+ (NSString *)imageToBase64Str:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodeImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodeImageStr;
}
#pragma mark - base64图片转码器
+ (UIImage *)base64StrToImage:(NSString *)encodedImageStr {
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}
@end
