//
//  LJBDropListView.h
//  一公里
//
//  Created by 李居彬 on 15/12/19.
//  Copyright © 2015年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJBDropListViewDelegate <NSObject>

/**
 数据源 行数
 */
- (NSInteger)ljbDropListView:(UIView *)dropListView;

/**
 数据源 内容
 */
- (NSString *)ljbDropListView:(UIView *)dropListView cellForRow:(NSInteger)row;

/**
 选中 内容
 */
- (void)ljbDropListView:(UIView *)dropListView didSelectRow:(NSInteger)row;

/**
 默认 选中行
 */
@optional
- (NSInteger)defaultShowRowLjbDropListView:(UIView *)dropListView;

@end

@interface LJBDropListView : UIImageView

@property(assign) id<LJBDropListViewDelegate> delegate;

@property(nonatomic,strong)UIView *superMainView;//主控制器

@property(assign)CGFloat edgeX;
@property(assign)CGFloat edgeY;

@property(nonatomic,strong)UITableView *tableView;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;

@property(nonatomic,weak)UILabel *resultLab;


@end
