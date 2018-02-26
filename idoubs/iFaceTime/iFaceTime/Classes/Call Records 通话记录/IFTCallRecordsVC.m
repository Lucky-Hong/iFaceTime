/*
 *    |  ____ \    / ____ \   | |\   | |   / _______|
 *    | |    \ |  / /    \ \  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |____/ /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */

//
//  IFTCallRecordsVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

/** 滑动标题栏高度 */
static const CGFloat TitleHeight = 40.f;
/** 滑动标题栏宽度 */
static const CGFloat LabelWidth = kMainScreenWidth/3;

#import "IFTCallRecordsVC.h"
#import "CYLTabBarController.h"
#import "IFTSearchBarView.h"
#import "IFTSlideHeaderLabel.h"
#import "IFTCallRecordsTableVC.h"

@interface IFTCallRecordsVC () <UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) UIScrollView *titleScroll;        // 标题栏scrollView
@property (nonatomic, strong) UIScrollView *contentScroll;      // 内容栏scrollView
@property (nonatomic, strong) CALayer *bottomLine;              // 滑动短线
@property (nonatomic, copy) NSString *identifier;               // 滑动标题标识
@property (nonatomic, copy) NSArray *scrolTitleArr;             // 标题数组

@end

@implementation IFTCallRecordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"通话记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupContectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupContectView {
    float height = CYL_IS_IPHONE_X ? kMainScreenHeight-64-65:kMainScreenHeight-64-49;
    _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, height)];
    [self.view addSubview:_containerScrollView];
    _containerScrollView.contentSize = CGSizeMake(kMainScreenWidth, height + 50);
    _containerScrollView.delegate = self;
    [self addSearchBarView];
    [self addScrollPageView];
}

- (void)addSearchBarView {
    UIView *searchBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    searchBarBgView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    [_containerScrollView addSubview:searchBarBgView];
    IFTSearchBarView *searchBar = [[IFTSearchBarView alloc] init];
    [searchBarBgView addSubview:searchBar];
    [searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBarBgView.mas_left).offset(15);
        make.right.equalTo(searchBarBgView.mas_right).offset(-15);
        make.centerY.equalTo(searchBarBgView.mas_centerY);
        make.height.equalTo(@32);
    }];
}

- (void)addScrollPageView {
    self.scrolTitleArr = @[@"全部通话", @"未接通话", @"群聊通话"];
    [self constructSlideHeaderView];
    [self constructContentView];
}

// 添加滚动标题栏
- (void)constructSlideHeaderView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kMainScreenWidth, 40)];
//        backgroundView.backgroundColor = [UIColor redColor];
    [self.containerScrollView addSubview:backgroundView];
    
    self.titleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)]; // 滚动窗口
    //        _titleScroll.backgroundColor = [UIColor greenColor];
    self.titleScroll.showsHorizontalScrollIndicator = NO;
    self.titleScroll.showsVerticalScrollIndicator = NO;
    self.titleScroll.scrollsToTop = NO;
    
    [backgroundView addSubview:self.titleScroll];
    
    // 0.添加标题label
    [self addLabel];
    // 1.底部滑动短线
    self.bottomLine = [CALayer layer];
    [self.bottomLine setBackgroundColor:[UIColor colorWithHex:@"#5184FF"].CGColor];
    self.bottomLine.frame = CGRectMake(0, self.titleScroll.frame.size.height-2, LabelWidth, 2);
    [self.titleScroll.layer addSublayer:self.bottomLine];
}

/** 添加标题栏label */
- (void)addLabel {
    for (int i = 0; i < self.scrolTitleArr.count; i++) {
        CGFloat lbW = LabelWidth;        //宽
        CGFloat lbH = TitleHeight;       //高
        CGFloat lbX = i * lbW;           //X
        CGFloat lbY = 0;                 //Y
        IFTSlideHeaderLabel *label = [[IFTSlideHeaderLabel alloc] initWithFrame:(CGRectMake(lbX, lbY, lbW, lbH))];
        //        UIViewController *vc = self.childViewControllers[i];
        label.text = self.scrolTitleArr[i];
        label.font = [UIFont fontWithName:@"HYQiHei" size:14];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithHex:@"#333333"];
        [self.titleScroll addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        //        label.backgroundColor = [UIColor greenColor];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    
    self.titleScroll.contentSize = CGSizeMake(LabelWidth * self.scrolTitleArr.count, 0);
    
    // 默认选择第一个label
    IFTSlideHeaderLabel *lable = [self.titleScroll.subviews firstObject];
    lable.scale = 1.0;
}


#pragma mar k- Event reponse

- (void)labelClick:(UITapGestureRecognizer *)recognizer {
    IFTSlideHeaderLabel *label = (IFTSlideHeaderLabel *)recognizer.view;
    CGFloat offsetX = label.tag * self.contentScroll.frame.size.width;
    
    CGFloat offsetY = self.contentScroll.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.contentScroll setContentOffset:offset animated:YES];
}

/** 添加正文内容页 */
- (void)constructContentView {
    self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, kMainScreenWidth, kMainScreenHeight - 64 - 40 - 49)]; // 滚动窗口
    self.contentScroll.scrollsToTop = NO;
    self.contentScroll.showsHorizontalScrollIndicator = NO;
    self.contentScroll.pagingEnabled = YES;
    self.contentScroll.delegate = self;
    self.contentScroll.tag = 88888;
    
    [self.containerScrollView addSubview:self.contentScroll];
    
    // 添加子控制器
    for (int i=0; i<self.scrolTitleArr.count ;i++) {
        
        IFTCallRecordsTableVC *callRecordsVC = [[IFTCallRecordsTableVC alloc] init];
        callRecordsVC.tableView.delegate = self;
        [self addChildViewController:callRecordsVC];
        
    }
    
    // 添加默认控制器
    IFTCallRecordsTableVC *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.contentScroll.bounds;
    [self.contentScroll addSubview:vc.view];
    //        self.needScrollToTopPage = self.childViewControllers[0];
    
    
    
    CGFloat contentX = self.scrolTitleArr.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScroll.contentSize = CGSizeMake(contentX, 0);
}

#pragma mark - UIScrollViewDelegate

/** 滚动结束后调用（代码导致的滚动停止） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.tag == 88888) {
        // 获得索引
        NSUInteger index = scrollView.contentOffset.x / self.contentScroll.frame.size.width;
        // 滚动标题栏
        IFTSlideHeaderLabel *titleLable = (IFTSlideHeaderLabel *)self.titleScroll.subviews[index];
        
        // 把下划线与titieLabel的frame绑定(下划线滑动方式)
        self.bottomLine.frame = CGRectMake(titleLable.frame.origin.x, self.titleScroll.frame.size.height-22+20, LabelWidth, 2);
        
        CGFloat offsetx = titleLable.center.x - self.titleScroll.frame.size.width * 0.5;
        
        CGFloat offsetMax = self.titleScroll.contentSize.width - self.titleScroll.frame.size.width;
        
        if (offsetx < 0) {
            offsetx = 0;
        } else if (offsetx > offsetMax){
            offsetx = offsetMax;
        }
        
        CGPoint offset = CGPointMake(offsetx, self.titleScroll.contentOffset.y);
        [self.titleScroll setContentOffset:offset animated:YES];
        
        // 将控制器添加到contentScroll
        UIViewController *vc = self.childViewControllers[index];
        //    vc.index = index;
        
        [self.titleScroll.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx != index) {
                IFTSlideHeaderLabel *temlabel = self.titleScroll.subviews[idx];
                temlabel.scale = 0.0;
            }
        }];
        
        //    [self setScrollToTopWithTableViewIndex:index];
        
        if (vc.view.superview) return;//阻止vc重复添加
        vc.view.frame = scrollView.bounds;
        [self.contentScroll addSubview:vc.view];
        
    }
    DONG_Log(@"滚动结束后调用（代码导致的滚动停止)");
}

/** 滚动结束（手势导致的滚动停止） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 88888) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
    
    if (self.containerScrollView.contentOffset.y < 0) {
        [self.containerScrollView setContentOffset:CGPointZero animated:YES];
    }
    
    DONG_Log(@"滚动结束后调用（手势导致的滚动停止)");
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 88888) {
        // 取出绝对值 避免最左边往右拉时形变超过1
        CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
        NSUInteger leftIndex = (int)value;
        NSUInteger rightIndex = leftIndex + 1;
        CGFloat scaleRight = value - leftIndex;
        CGFloat scaleLeft = 1 - scaleRight;
        IFTSlideHeaderLabel *labelLeft = self.titleScroll.subviews[leftIndex];
        labelLeft.scale = scaleLeft;
        // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
        if (rightIndex < self.titleScroll.subviews.count) {
            IFTSlideHeaderLabel *labelRight = self.titleScroll.subviews[rightIndex];
            labelRight.scale = scaleRight;
        }
        
        // 下划线即时滑动
        float modulus = scrollView.contentOffset.x/self.contentScroll.contentSize.width;
        self.bottomLine.frame = CGRectMake(modulus * self.titleScroll.contentSize.width, self.titleScroll.frame.size.height-22+20, LabelWidth, 2);
        
    } else {
        
        // 判断是否是子视图滚动
        BOOL isContent = [scrollView isKindOfClass:[UITableView class]];
        if (isContent) { // 滚动子视图
            BOOL isScrollDown = self.containerScrollView.contentOffset.y <= 0;
            CGFloat offsetY = scrollView.contentOffset.y + self.containerScrollView.contentOffset.y;
            if (isScrollDown) { // 下拉
                [scrollView setContentOffset:CGPointZero];
                [self.containerScrollView setContentOffset:CGPointMake(0, offsetY)];
               
            } else if (!isScrollDown) { // 上拉
                
                if (scrollView.contentOffset.y < 50) {
                    [self.containerScrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
                } else {
                    [self.containerScrollView setContentOffset:CGPointMake(0, 50)];
                }
            }
        } else if (scrollView == self.containerScrollView) { // 滚动父视图
            if (self.containerScrollView.contentOffset.y >= 50) {
                [self.containerScrollView setContentOffset:CGPointMake(0, 50)];
            }
        }
        DONG_Log(@"scrollView.contentoffset-->%f", scrollView.contentOffset.y)
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 处理因子视图向下拖拽而导致父视图无法回到原位置
    BOOL isContent = [scrollView isKindOfClass:[UITableView class]];
    if (isContent) {
        CGFloat offsetY = self.containerScrollView.contentOffset.y;
        if (offsetY < 0) {
            [self.containerScrollView setContentOffset:CGPointZero animated:YES];
        }
    }
}


@end
