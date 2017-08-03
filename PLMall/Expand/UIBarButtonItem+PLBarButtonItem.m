//
//  UIBarButtonItem+PLBarButtonItem.m
//  
//
//  Created by PengLiang on 2017/8/3.
//
//

#import "UIBarButtonItem+PLBarButtonItem.h"

@implementation UIBarButtonItem (PLBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withHighlighted:(UIImage *)highlightedImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:btn.frame];
    [contentView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withSelected:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:btn.frame];
    [contentView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action title:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -20);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
