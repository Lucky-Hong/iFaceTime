//
//  IFTTabbarConfig.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTTabbarConfig.h"
#import <UIKit/UIKit.h>

static CGFloat const CYLTabBarControllerHeight = 49;

//@interface CYLBaseNavigationController : UINavigationController
//@end
//
//@implementation CYLBaseNavigationController
//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}

//@end

#import "IFTPulsButton.h"
#import "IFTCallRecordsVC.h"
#import "IFTContactVC.h"
#import "IFTMessageVC.h"
#import "IFTMineVC.h"
#import "IFTBaseNavigationController.h"

@interface IFTTabbarConfig () <UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation IFTTabbarConfig


#pragma mark - getter

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero; // UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero; // UIOffsetMake(0, MAXFLOAT);
//        imageInsets = UIEdgeInsetsMake(-0.2, -0.2, -0.2, -0.2);
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment
                                                                                                 context:self.context];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    IFTCallRecordsVC *recordsVC = [[IFTCallRecordsVC alloc] init];
    UIViewController *vc1 = [[IFTBaseNavigationController alloc] initWithRootViewController:recordsVC];
    IFTContactVC *contactVC = [[IFTContactVC alloc] init];
    UIViewController *vc2 = [[IFTBaseNavigationController alloc] initWithRootViewController:contactVC];
    IFTMessageVC *messageVC = [[IFTMessageVC alloc] init];
    UIViewController *vc3 = [[IFTBaseNavigationController alloc] initWithRootViewController:messageVC];
    IFTMineVC *mineVC = [[IFTMineVC alloc] init];
    UIViewController *vc4 = [[IFTBaseNavigationController alloc] initWithRootViewController:mineVC];
    
    NSArray *viewControllers = @[vc1, vc2, vc3, vc4 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"通话记录",
                            CYLTabBarItemImage : @"CallRecords",
                            CYLTabBarItemSelectedImage : @"CallRecords_Selected",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"联系人",
                            CYLTabBarItemImage : @"Contact",
                            CYLTabBarItemSelectedImage : @"Contact_Selected",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"Message",
                            CYLTabBarItemSelectedImage : @"Message_Selected",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"Mine",
                            CYLTabBarItemSelectedImage : @"Mine_Selected",
                            };
    
    NSArray *tabBarItemsAttributes = @[dict1, dict2, dict3, dict4];
    return tabBarItemsAttributes;
}

// 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : CYLTabBarControllerHeight;
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:@"#999999"];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:@"#4787FC"];
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
//     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    // 设置背景图片
    //UITabBar *tabBarAppearance = [UITabBar appearance];
    //FIXED: #196
    //UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"tab_bar"];
    //UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage toScale:1.0];
    //     [tabBarAppearance setBackgroundImage:scanedTabBarBackgroundImage];
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

// 横竖屏切换
- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}


+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
