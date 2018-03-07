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
//  IFTContactListTableVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/24.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTContactListTableVC.h"
#import "IFTContactCell.h"
#import "IFTContactDetailInfoVC.h"
#import "IFTContactModel.h"

@interface IFTContactListTableVC () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL fingerIsTouch;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * groupDataArray;
@property (nonatomic, strong) NSMutableArray * groupTitleArray;

@end

@implementation IFTContactListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.dataArray = [NSMutableArray arrayWithObjects:@"李白",@"张三",@"重庆",@"重量",@"调节",@"调用",@"小白",@"小明",@"千珏",@"黄家驹", @"鼠标",@"hello",@"多美丽",@"肯德基",@"登记", @"大奔", @"周傅", @"爱德华", @"啦文琪羊", @"文强", @"过段时间", @"等等", @"各个", @"宵夜", @"贝尔",@"而结婚", @"返回*", @"你还", @"与非门", @"是的", @"模块", @"没做",@"俄文", @"咳嗽", @"232", @"fh",@"C罗",@"邓肯", nil];

    self.groupTitleArray = [NSMutableArray arrayWithCapacity:0];
    self.groupDataArray = [NSMutableArray arrayWithCapacity:0];
    [self handleDataArray:self.dataArray GroupDataArray:self.groupDataArray GroupTitleArray:self.groupTitleArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSString *)transform:(NSString *)chinese {
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    return [pinyin uppercaseString];
}

// 按首字母分组
- (void)handleDataArray:(NSArray*)dataArray GroupDataArray:(NSMutableArray*)groupDataArray GroupTitleArray:(NSMutableArray*)groupTitleArray {
    NSMutableArray * groupCurrentDataArray = nil;
    NSString * lastFirstLetter = nil;
    NSString * currentFirstLetter = nil;
    dataArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        NSString * obj1FirstLetter = [[self transform:obj1] substringToIndex:1];
        NSString * obj2FirstLetter = [[self transform:obj2] substringToIndex:1];
        return [obj1FirstLetter compare:obj2FirstLetter];
    }];
    for(NSString * name in dataArray){
        currentFirstLetter = [[self transform:name] substringToIndex:1];
        if(![lastFirstLetter isEqualToString:currentFirstLetter]){
            groupCurrentDataArray = [[NSMutableArray alloc] init];
            [groupTitleArray addObject:currentFirstLetter];
            [groupDataArray addObject:groupCurrentDataArray];
        }
        [groupCurrentDataArray addObject:name];
        lastFirstLetter = currentFirstLetter;
    }
    if([[groupTitleArray firstObject] isEqualToString:@"#"]){
        id groupTile = [groupTitleArray firstObject];
        [groupTitleArray removeObject:groupTile];
        [groupTitleArray addObject:groupTile];
        
        id dataValue = [groupTitleArray firstObject];
        [groupTitleArray removeObject:dataValue];
        [groupTitleArray addObject:dataValue];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.groupTitleArray.count;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.groupDataArray[section] count];
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.groupDataArray[indexPath.section][indexPath.row];
    IFTContactCell *cell = [IFTContactCell cellWithTableView:tableView];
    IFTContactModel *contactModel = [[IFTContactModel alloc] init];
    contactModel.name = name;
    cell.contactModel = contactModel;
    return cell;
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IFTContactDetailInfoVC *contactInfoVC = [[IFTContactDetailInfoVC alloc] init];
    [[UIWindow currentViewController].navigationController pushViewController:contactInfoVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
    view.backgroundColor = [UIColor colorWithHex:@"#EBEBF2"];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 25)];
    headerLabel.font = [UIFont systemFontOfSize:14.f];
    headerLabel.textColor = [UIColor colorWithHex:@"#666666"];
    NSString * title = self.groupTitleArray[section];
    headerLabel.text = title;
    [view addSubview:headerLabel];

    return view;
}


#pragma mark - UIScrollView

// 判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    DONG_Log(@"接触屏幕");
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    DONG_Log(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
//                if (!self.fingerIsTouch) {// 这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
//                    return;
//                }
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ContactLeaveTop" object:nil]; // 到顶通知父视图改变状态
    }
    self.tableView.showsVerticalScrollIndicator = _canScroll? YES:NO;
}

// 索引

//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return self.groupTitleArray;
//}
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    return  index;
//}




@end
