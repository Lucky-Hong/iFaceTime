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
//  IFTContainerCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/24.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTContainerCell.h"
#import "IFTSlideHeaderLabel.h"
#import "IFTContactListTableVC.h"


/** 滑动标题栏高度 */
static const CGFloat TitleHeight = 40.f;
/** 滑动标题栏宽度 */
static const CGFloat LabelWidth = 80.f;

@interface IFTContainerCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScroll;        // 标题栏scrollView
@property (nonatomic, strong) UIScrollView *contentScroll;      // 内容栏scrollView
@property (nonatomic, strong) CALayer *bottomLine;              // 滑动短线
@property (nonatomic, copy) NSString *identifier;               // 滑动标题标识
@property (nonatomic, copy) NSArray *scrolTitleArr;             // 标题数组
@property (nonatomic, strong) NSMutableArray *childViewControllers;

@end

@implementation IFTContainerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      [self setupContentView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTContainerCell";
    IFTContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[IFTContainerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setupContentView {
    self.scrolTitleArr = @[@"全部联系人", @"家庭联系人", @"同学" , @"同事" , @"驴友"];
    self.childViewControllers = [NSMutableArray arrayWithCapacity:0];
    
    [self constructSlideHeaderView];
    [self constructContentView];
}

// 添加滚动标题栏
- (void)constructSlideHeaderView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kMainScreenWidth, 40)];
    //    backgroundView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:backgroundView];
    
    self.titleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kMainScreenWidth, 40)]; // 滚动窗口
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
    self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kMainScreenWidth, kMainScreenHeight - 64 - 40 - 49)]; // 滚动窗口
    self.contentScroll.scrollsToTop = NO;
    self.contentScroll.showsHorizontalScrollIndicator = NO;
    self.contentScroll.pagingEnabled = YES;
    self.contentScroll.delegate = self;
    [self.contentView addSubview:self.contentScroll];
    
    // 添加子控制器
    for (int i=0; i<self.scrolTitleArr.count ;i++) {
        
        IFTContactListTableVC *contactTableVC = [[IFTContactListTableVC alloc] init];
        [self.childViewControllers addObject:contactTableVC];
        
    }
    
    // 添加默认控制器
    IFTContactListTableVC *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.contentScroll.bounds;
    [self.contentScroll addSubview:vc.view];
    //        self.needScrollToTopPage = self.childViewControllers[0];
    
    
    
    CGFloat contentX = self.scrolTitleArr.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScroll.contentSize = CGSizeMake(contentX, 0);
}

#pragma mark - UIScrollViewDelegate

/** 滚动结束后调用（代码导致的滚动停止） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
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
    
    if (vc.view.superview) return; // 阻止vc重复添加
    vc.view.frame = scrollView.bounds;
    [self.contentScroll addSubview:vc.view];
    
    
}

/** 滚动结束（手势导致的滚动停止） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
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
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([NSStringFromClass(touch.view.class) isEqualToString:@"FirstTableView"]) {
//        // 如果是FirstTableView的范围，那么手势不生效
//        return NO;
//    }
//    return YES;
//}

#pragma mark - Setter

- (void)setCellShouldScroll:(BOOL)cellShouldScroll {
    for (IFTContactListTableVC *vc in _childViewControllers) {
        vc.canScroll = cellShouldScroll;
        if (!cellShouldScroll) { // 如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            vc.tableView.contentOffset = CGPointZero;
        }
    }
    _cellShouldScroll = cellShouldScroll;
}

@end
