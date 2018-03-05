//
//  IFTContactFloatingView.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/5.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTContactFloatingView.h"
#import "IFTFloatingViewCell.h"
#import "IFTAddContactVC.h"

@interface IFTContactFloatingView() <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *floatingBG;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation IFTContactFloatingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
        [self setupSubViews];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_floatingBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(136, 132));
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self).offset(64);
    }];
    
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_floatingBG).offset(5);
        make.right.equalTo(_floatingBG.mas_right).offset(-5);
        make.top.equalTo(_floatingBG.mas_top).offset(10);
        make.bottom.equalTo(_floatingBG.mas_bottom).offset(-6);
    }];
}

- (void)setupSubViews {
    self.dataArray = @[@{@"AddContact" : @"添加联系人"},
                       @{@"ManageGroups" : @"分组管理"},
                       @{@"CreatGroupChat" : @"创建群聊"}];
    
    UIView *floatingBG = [[UIView alloc] init];
    [self addSubview:floatingBG];
    _floatingBG = floatingBG;
    UIImage *backGroundImage = [UIImage imageNamed:@"FloatingBG_Contact"];
    _floatingBG.contentMode = UIViewContentModeScaleToFill;
    _floatingBG.layer.contents = (__bridge id _Nullable)(backGroundImage.CGImage);
    // tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    // tableView
    [_floatingBG addSubview:self.tableView];
}

-(void)tapView:(UITapGestureRecognizer *)sender{
    self.hidden = YES;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:_floatingBG.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.scrollEnabled = NO;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTFloatingViewCell *cell = [IFTFloatingViewCell cellWithTableView:tableView];
    [cell setModel:self.dataArray indexPath:indexPath];
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        IFTAddContactVC *addContactVC = [[IFTAddContactVC alloc] init];
        UIViewController *currentVC = [UIWindow currentViewController];
        [currentVC.navigationController pushViewController:addContactVC animated:YES];
    } else if (indexPath.row == 1) {
        
    } else {
        
    }
    self.hidden = YES;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[IFTContactFloatingView class]]) {
        return YES;
    } else {
        return NO;
    }
}

@end
