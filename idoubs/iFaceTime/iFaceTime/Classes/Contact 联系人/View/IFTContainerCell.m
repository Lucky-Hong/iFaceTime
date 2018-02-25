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

/** 滑动标题栏高度 */
static const CGFloat TitleHeight = 40.f;
/** 滑动标题栏宽度 */
static const CGFloat LabelWidth = 100.f;

@interface IFTContainerCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScroll;        // 标题栏scrollView
@property (nonatomic, strong) UIScrollView *contentScroll;      // 内容栏scrollView
@property (nonatomic, strong) CALayer *bottomLine;              // 滑动短线
@property (nonatomic, copy) NSString *identifier;               // 滑动标题标识
@property (nonatomic, copy) NSArray *scrolTitleArr;             // 标题数组

@end

@implementation IFTContainerCell

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
    [cell setupContentView];
    return cell;
}

- (void)setupContentView {
    self.scrolTitleArr = @[@"全部联系人", @"家庭联系人", @"同学"];
    [self constructSlideHeaderView];
    [self constructContentVie];
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
- (void)constructContentVie {
    self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kMainScreenWidth, kMainScreenHeight - 64 - 40 - 49)]; // 滚动窗口
    self.contentScroll.scrollsToTop = NO;
    self.contentScroll.showsHorizontalScrollIndicator = NO;
    self.contentScroll.pagingEnabled = YES;
    self.contentScroll.delegate = self;
        _contentScroll.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.contentScroll];
    // 添加子控制器
        for (int i=0; i<self.scrolTitleArr.count ;i++) {
            switch (i) {
                case 0:{ // 剧集
//                    SCMoiveAllEpisodesVC *episodesVC = [[SCMoiveAllEpisodesVC alloc] init];
//                    [self addChildViewController:episodesVC];
//                    episodesVC.filmSetsArr = self.filmSetsArr;
//                    break;
                }
                case 1:{ // 详情
//                    SCMoiveIntroduceVC *introduceVC = DONG_INSTANT_VC_WITH_ID(@"HomePage", @"SCMoiveIntroduceVC");
//                    introduceVC.model = self.filmIntroduceModel;
//                    [self addChildViewController:introduceVC];
                    
                    break;
                }
                case 2:{ // 精彩推荐
//                    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];// 布局对象
//                    SCMoiveRecommendationCollectionVC *vc = [[SCMoiveRecommendationCollectionVC alloc] initWithCollectionViewLayout:layout];
//                    vc.filmModel = self.filmModel;
//                    vc.bannerFilmModelArray = self.bannerFilmModelArray;
//                    [self addChildViewController:vc];
                    break;
                }
                default:
                    break;
            }
        }
        
        // 添加默认控制器
//        SCMoiveIntroduceVC *vc = [self.childViewControllers firstObject];
//        vc.view.frame = self.contentScroll.bounds;
//        [self.contentScroll addSubview:vc.view];
        //    self.needScrollToTopPage = self.childViewControllers[0];
        
   
    
    CGFloat contentX = self.scrolTitleArr.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScroll.contentSize = CGSizeMake(contentX, 0);
}


@end
