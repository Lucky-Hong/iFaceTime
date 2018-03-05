//
//  IFTMoreFunctionView.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/5.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMoreFunctionView.h"
#import "IFTFloatingViewCell.h"

@interface IFTMoreFunctionView() <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *floatingBG;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IFTMoreFunctionView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

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
        make.size.mas_equalTo(CGSizeMake(136, 97));
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self).offset(64);
    }];
    
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_floatingBG).offset(5);
        make.right.equalTo(_floatingBG.mas_right).offset(-5);
        make.top.equalTo(_floatingBG.mas_top).offset(12);
        make.bottom.equalTo(_floatingBG.mas_bottom).offset(-6);
    }];
}

- (void)setupSubViews {
    UIView *floatingBG = [[UIView alloc] init];
    [self addSubview:floatingBG];
    _floatingBG = floatingBG;
    UIImage *backGroundImage = [UIImage imageNamed:@"FloatingBG_CallRecords"];
    _floatingBG.contentMode=UIViewContentModeScaleAspectFill;
    _floatingBG.layer.contents=(__bridge id _Nullable)(backGroundImage.CGImage);
    // tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //tableView
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFTFloatingViewCell *cell = [IFTFloatingViewCell cellWithTableView:tableView];
    [cell setModel:nil indexPath:indexPath];
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DONG_Log(@"+++++++++++++++");
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[IFTMoreFunctionView class]]) {
        return YES;
    } else {
        return NO;
    }
}


@end
