//
//  IFTAddContactVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/2.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTAddContactVC.h"
#import "IFTAddContactCell.h"
#import "IFTAddContectSearchTextField.h"
#import "IFTRecommendContactCell.h"
#import "IFTMoreContactView.h"

@interface IFTAddContactVC () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IFTAddContectSearchTextField *searchTextField;

@end

@implementation IFTAddContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"添加联系人";
    
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setUpSubViews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    IFTMoreContactView *moreContactView = [[NSBundle mainBundle] loadNibNamed:@"IFTMoreContactView" owner:nil options:nil][0];
    [self.view addSubview:moreContactView];
    [moreContactView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
        make.height.equalTo(@45);
    }];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 220) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [UIView new];
        
    // tableHeaderView
        UIView *headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
        headerBgView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        _tableView.tableHeaderView = headerBgView;
        IFTAddContectSearchTextField *textField = [[IFTAddContectSearchTextField alloc] init];
        textField.placeholder = @"手机号/昵称/CA卡号";
        textField.font = [UIFont systemFontOfSize:14];
        textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.backgroundColor = [UIColor whiteColor];
        [headerBgView addSubview:textField];
        _searchTextField = textField;
        [textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(headerBgView);
            make.height.equalTo(@40);
            make.centerY.equalTo(headerBgView);
        }];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 329, kMainScreenWidth, 175) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceHorizontal = YES; // 设置当item较少时仍可以滑动
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 注册cell、sectionHeader、sectionFooter
        [_collectionView registerNib:[UINib nibWithNibName:@"IFTRecommendContactCell" bundle:nil] forCellWithReuseIdentifier:@"IFTRecommendContactCell"];
        
    }
    return _collectionView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTAddContactCell *cell = [IFTAddContactCell cellWithTableView:tableView];
    [cell setModel:nil indexPath:indexPath];
    return cell;
    
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        IFTAboutVC *aboutVC = DONG_INSTANT_VC_WITH_ID(@"Main", @"IFTAboutVC");
//        [self.navigationController pushViewController:aboutVC animated:YES];
//    } else if (indexPath.section == 1 && indexPath.row == 1) {
//
//    } else if (indexPath.section == 1 && indexPath.row == 2) {
//
//    }
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFTRecommendContactCell *cell = [IFTRecommendContactCell cellWithCollectionView:collectionView indexPath:indexPath];
    
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

/** item Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (CGSize){110, 175};
}

/** Section EdgeInsets */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/** item水平间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.f;
}

/** item垂直间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 点击某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DONG_Log(@"====================");
}

- (IBAction)toSeeMoreRecommand:(id)sender {
    DONG_Log(@"更多联系人");
}

@end
