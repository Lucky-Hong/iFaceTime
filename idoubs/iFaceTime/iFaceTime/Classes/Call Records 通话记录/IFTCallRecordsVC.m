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



#import "IFTCallRecordsVC.h"
#import "CYLTabBarController.h"
#import "IFTSearchBarView.h"
#import "IFTCallRecordsTableVC.h"
#import "MLMSegmentManager.h"
#import "IFTCallRecordsContainerCell.h"
#import "IFTBaseTableView.h"
#import "IFTMoreFunctionView.h"
#import "IFTAddContactVC.h"

@interface IFTCallRecordsVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) IFTBaseTableView *tableView;
@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong)  IFTCallRecordsContainerCell *containerCell;
@property (nonatomic, strong) IFTMoreFunctionView *floatingView;

@property (nonatomic, strong) UIScrollView *titleScroll;        // 标题栏scrollView
@property (nonatomic, strong) UIScrollView *contentScroll;      // 内容栏scrollView
@property (nonatomic, strong) CALayer *bottomLine;              // 滑动短线
@property (nonatomic, copy) NSString *identifier;               // 滑动标题标识

@property (nonatomic, strong) MLMSegmentHead *segmentHead;
@property (nonatomic, strong) MLMSegmentScroll *segmentScroll;
@property (nonatomic, copy) NSArray *scrolTitleArr;             // 标题数组
@property (nonatomic,assign) BOOL shouldScroll;                 // 默认刚开始是YES

@end

@implementation IFTCallRecordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"通话记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.shouldScroll = YES;
    
    [self setupSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"CallRecordsLeaveTop" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark- private methods

- (void)setupSubViews {
    [self addRightBBI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.floatingView];
    
}

- (void)addRightBBI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enlargedEdge = 15.f;
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setImage:[UIImage imageNamed:@"More"] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(moreFunction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    rightNegativeSpacer.width = -30;

    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightNegativeSpacer, item, nil];
}

- (void)moreFunction {
    _floatingView.hidden = !_floatingView.hidden;
}


#pragma mark - Getter

- (IFTMoreFunctionView *)floatingView {
    if (!_floatingView) {
        _floatingView = [[IFTMoreFunctionView alloc] initWithFrame:self.view.bounds];
        _floatingView.hidden = YES;
//        DONG_WeakSelf(self);
//        _floatingView.selectRowBlock = ^(NSIndexPath *indexPath){
//            IFTAddContactVC *addContactVC = [[IFTAddContactVC alloc] init];
//            [weakself.navigationController pushViewController:addContactVC animated:YES];
//        };
    }
    return _floatingView;
}

- (IFTBaseTableView *)tableView {
    if (!_tableView) {
        float height = CYL_IS_IPHONE_X ? kMainScreenHeight-64-65:kMainScreenHeight-64-49;
        _tableView = [[IFTBaseTableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // tableHeaderView
        UIView *tableHeadBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
        tableHeadBgView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        self.tableView.tableHeaderView = tableHeadBgView;
        IFTSearchBarView *searchBar = [[IFTSearchBarView alloc] init];
        [tableHeadBgView addSubview:searchBar];
        [searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tableView.tableHeaderView.mas_left).offset(15);
            make.right.equalTo(self.tableView.tableHeaderView.mas_right).offset(-15);
            make.centerY.equalTo(self.tableView.tableHeaderView.mas_centerY);
            make.height.equalTo(@32);
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTCallRecordsContainerCell *cell = [IFTCallRecordsContainerCell cellWithTableView:tableView];
    _containerCell = cell;
    [self addScrollPageView];
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CYL_IS_IPHONE_X ? kMainScreenHeight - 64 - 65 : kMainScreenHeight - 64 - 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (void)addScrollPageView {
    self.scrolTitleArr = @[@"全部通话", @"未接通话", @"群聊通话"];
    
    
    // 添加子控制器
    for (int i=0; i<self.scrolTitleArr.count; i++) {
        IFTCallRecordsTableVC *callRecordsVC = [[IFTCallRecordsTableVC alloc] init];
        [self addChildViewController:callRecordsVC];
    }
    
    _segmentHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) titles:_scrolTitleArr headStyle:SegmentHeadStyleLine layoutStyle:MLMSegmentLayoutDefault];
    _segmentHead.fontScale = 1;
    _segmentHead.fontSize = 14;
    _segmentHead.deSelectColor = [UIColor colorWithHex:@"#333333"];
    _segmentHead.selectColor = [UIColor colorWithHex:@"#4787FC"];
    _segmentHead.lineScale = 1;
    _segmentHead.lineColor = [UIColor colorWithHex:@"#4787FC"];;
    
    _segmentScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentHead.frame), kMainScreenWidth, self.tableView.frame.size.height-CGRectGetMaxY(_segmentHead.frame)) vcOrViews:self.childViewControllers];
    _segmentScroll.loadAll = YES;
    _segmentScroll.showIndex = 0;
    
    [MLMSegmentManager associateHead:_segmentHead withScroll:_segmentScroll completion:^{
        [self.containerCell.contentView addSubview:_segmentHead];
        [self.containerCell.contentView addSubview:_segmentScroll];
    }];
    
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = [_tableView rectForSection:0].origin.y;
    
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.shouldScroll) {
            self.shouldScroll = NO;
            self.containerCell.cellShouldScroll = YES;
            for (IFTCallRecordsTableVC *vc in self.childViewControllers) {
                vc.canScroll = YES;
                if (!vc.canScroll) { // 如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
                    vc.tableView.contentOffset = CGPointZero;
                }
            }
        }
    } else {
        if (!self.shouldScroll) { // 子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tableView.showsVerticalScrollIndicator = _shouldScroll? YES:NO;
}

#pragma mark - notify

- (void)changeScrollStatus { // 改变主视图的状态
    self.shouldScroll = YES;
    self.containerCell.cellShouldScroll = NO;
}



@end
