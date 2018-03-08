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
//  IFTContactVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTContactVC.h"
#import "CYLTabBarController.h"
#import "IFTMyGroupCell.h"
#import "IFTContactCell.h"
#import "IFTSection1Model.h"
#import "IFTContainerCell.h"
#import "IFTSearchBarView.h"
#import "IFTBaseTableView.h"
#import "IFTAddContactVC.h"
#import "IFTContactFloatingView.h"
#import "IFTContactModel.h"


@interface IFTContactVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) IFTBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *section1ModelArray;
@property (nonatomic, strong) IFTContainerCell *containerCell;      // section1 容器cell
@property (nonatomic, strong) IFTContactFloatingView *floatingView;

@property (nonatomic, assign) BOOL canScroll; // tableView是否可以滑动(默认为YES)


@end

@implementation IFTContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"联系人";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.canScroll = YES;
    
    [self setupSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"ContactLeaveTop" object:nil];
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

- (void)setupSubViews {
    [self addRightBBI];
    self.section1ModelArray = [NSMutableArray arrayWithCapacity:0];
    IFTSection1Model *myGroupMdoel = [IFTSection1Model initWithTitle:@"我的群组" iconName:@"MyGroup"];
    IFTSection1Model *convenienceServicesMdoel = [IFTSection1Model initWithTitle:@"便民服务" iconName:@"ConvenienceServices"];
    [_section1ModelArray addObject:myGroupMdoel];
    [_section1ModelArray addObject:convenienceServicesMdoel];
    
    [self setupTableView];
    [self.view addSubview:self.floatingView];
    
}

- (void)addRightBBI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enlargedEdge = 15.f;
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setImage:[UIImage imageNamed:@"More"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(moreFunction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    rightNegativeSpacer.width = -25;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightNegativeSpacer,item, nil];
}

- (void)moreFunction {
    _floatingView.hidden = !_floatingView.hidden;
}

#pragma mark - Getter

- (IFTContactFloatingView *)floatingView {
    if (!_floatingView) {
        _floatingView = [[IFTContactFloatingView alloc] initWithFrame:self.view.bounds];
        _floatingView.hidden = YES;
        DONG_WeakSelf(self);
        _floatingView.selectRowBlock = ^(NSIndexPath *indexPath){
            IFTAddContactVC *addContactVC = [[IFTAddContactVC alloc] init];
            [weakself.navigationController pushViewController:addContactVC animated:YES];
        };
    }
    return _floatingView;
}

- (void)setupTableView {
    IFTBaseTableView *tableView = [[IFTBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;

    self.tableView = tableView;
    [self.view addSubview:tableView];
    // tableHeaderView
    UIView *tableHeadBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 51)];
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
    
//    UISearchBar  *searchBar = [[UISearchBar alloc] init];
//    searchBar.delegate = self;
//    searchBar.placeholder = @"搜索";
//    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    [searchBar sizeToFit];
//
//    UIImage* searchBarBg = [self GetImageWithColor:[UIColor colorWithHex:@"#F0F0F6"] andHeight:32.0f];
//    //设置背景图片
//    [searchBar setBackgroundImage:searchBarBg];
//    //设置背景色
//    [searchBar setBackgroundColor:[UIColor colorWithHex:@"#F0F0F6"]];
//    self.tableView.tableHeaderView=searchBar;
    
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IFTMyGroupCell *cell = [IFTMyGroupCell cellWithTableView:tableView];
        [cell setModel:_section1ModelArray IndexPath:indexPath];
        return cell;
        
    } else if (indexPath.section == 1) {
        IFTContainerCell *cell = [IFTContainerCell cellWithTableView:tableView];
        _containerCell = cell;
        return cell;
    }
    return nil;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else {
        return CYL_IS_IPHONE_X ? kMainScreenHeight - 64 - 65 : kMainScreenHeight - 64 - 49;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IFTAddContactVC *addContactVC = [[IFTAddContactVC alloc] init];
    [self.navigationController pushViewController:addContactVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#EBEBF2"];
    if (section == 0) {
        return view;
    } else {
        return nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y - 64;

    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.containerCell.cellShouldScroll = YES;
        }
    } else {
        if (!self.canScroll) { // 子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tableView.showsVerticalScrollIndicator = _canScroll? YES:NO;
}

#pragma mark - notify

- (void)changeScrollStatus { // 改变主视图的状态
    self.canScroll = YES;
    self.containerCell.cellShouldScroll = NO;
}


@end
