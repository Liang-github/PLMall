//
//  UIBarButtonItem+PLBarButtonItem.h
//  
//
//  Created by PengLiang on 2017/8/3.
//
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (PLBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withHighlighted:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withSelected:(UIImage *)selectedImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action title:(NSString *)title;
@end
