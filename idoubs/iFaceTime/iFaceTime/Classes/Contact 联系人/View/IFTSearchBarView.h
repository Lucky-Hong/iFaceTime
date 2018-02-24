//
//  IFTSearchBarView.h
//  iFaceTime
//
//  Created by yesdgq on 2018/2/24.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFTSearchBarView : UIView <UITextFieldDelegate>

/** 搜索textField */
@property(nonatomic, strong) UITextField *searchTF;

@end
