//
//  LJBDropListView.m
//  一公里
//
//  Created by 李居彬 on 15/12/19.
//  Copyright © 2015年 viewcreator3d. All rights reserved.
//

#import "LJBDropListView.h"

#define cellHeight 40

#define kk_grayBg [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]

@interface LJBDropListView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *bgView;

@end

@implementation LJBDropListView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate {
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        //
        UILabel *resultLab = [[UILabel alloc] initWithFrame:self.bounds];
        self.resultLab = resultLab;
        resultLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:resultLab];
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTableView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)showTableView:(UITapGestureRecognizer *)tap {
    if (self.tableView.isHidden) {
        [self tapHiddenTableView:nil];
    } else {
        self.bgView = [[UIView alloc] initWithFrame:self.superMainView.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHiddenTableView:)];
        [self.bgView addGestureRecognizer:tap];
        [self.superMainView addSubview:self.bgView];
        [self.bgView addSubview:self.tableView];
        [self.tableView reloadData];
    }
}

- (void)tapHiddenTableView:(UITapGestureRecognizer *)tap {
    [self.bgView removeFromSuperview];
    [self.tableView removeFromSuperview];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    //
    NSInteger count = [self.delegate ljbDropListView:self];
    CGFloat tbX = self.frame.origin.x+self.edgeX;
    CGFloat tbY = CGRectGetMaxY(self.frame)+self.edgeY;
    CGFloat tbW = self.frame.size.width;
    CGFloat tbH = 0;
    if (count < 4) {
        tbH = count * cellHeight;
    } else {
        tbH = 4 * cellHeight;
    }
    _tableView.frame = CGRectMake(tbX, tbY, tbW, tbH);
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.delegate ljbDropListView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.tag = section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectRow:)];
    [view addGestureRecognizer:tap];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, tableView.frame.size.width, cellHeight - 1);
    UILabel *label = [[UILabel alloc] init];
    label.frame = view.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self.delegate ljbDropListView:self cellForRow:section];
    label.textColor = [UIColor blackColor];
    label.font = self.resultLab.font;
    [view addSubview:label];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, CGRectGetMaxY(view.frame), view.frame.size.width, 1);
    lineView.backgroundColor = kk_grayBg;
    [view addSubview:lineView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return cellHeight;
}

- (void)didSelectRow:(UITapGestureRecognizer *)tap {
    UIView *view = tap.view;
    self.resultLab.text = [self.delegate ljbDropListView:self cellForRow:view.tag];
    [self.delegate ljbDropListView:self didSelectRow:view.tag];
    [self tapHiddenTableView:nil];
}

- (void)setSuperMainView:(UIView *)superMainView {
    _superMainView = superMainView;
    
    if ([self.delegate respondsToSelector:@selector(defaultShowRowLjbDropListView:)]) {
        NSInteger row = [self.delegate defaultShowRowLjbDropListView:self];
        self.resultLab.text = [self.delegate ljbDropListView:self cellForRow:row];
        [self.delegate ljbDropListView:self didSelectRow:row];
    }
    
}

@end
