//
//  ViewController.m
//  dropList
//
//  Created by 李居彬 on 15/12/20.
//  Copyright © 2015年 tlj. All rights reserved.
//

#import "ViewController.h"
#import "LJBDropListView.h"

@interface ViewController ()<LJBDropListViewDelegate>

@property(nonatomic,strong)NSArray *array1;
@property(nonatomic,strong)NSArray *array2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array1 = [NSArray arrayWithObjects:@"list1-a1",@"list1-a2",@"list1-a3",@"list1-a4",@"list1-a5", nil];
    self.array2 = [NSArray arrayWithObjects:@"list2-a1",@"list2-a2",@"list2-a3", nil];
    LJBDropListView *dropList1 = [[LJBDropListView alloc] initWithFrame:CGRectMake(100, 100, 200, 40) delegate:self];
    dropList1.tag = 1;
    dropList1.image = [UIImage imageNamed:@"xuanze"];
    dropList1.superMainView = self.view;
    [self.view addSubview:dropList1];
    
    LJBDropListView *dropList2 = [[LJBDropListView alloc] initWithFrame:CGRectMake(100, 400, 200, 40) delegate:self];
    dropList2.tag = 2;
    dropList2.image = [UIImage imageNamed:@"xuanze"];
    dropList2.superMainView = self.view;
    [self.view addSubview:dropList2];
}

- (NSInteger)ljbDropListView:(UIView *)dropListView {
    if (dropListView.tag == 1) {
        return self.array1.count;
    }
    return self.array2.count;
}

- (NSString *)ljbDropListView:(UIView *)dropListView cellForRow:(NSInteger)row {
    if (dropListView.tag == 1) {
        return self.array1[row];
    }
    return self.array2[row];
}

- (void)ljbDropListView:(UIView *)dropListView didSelectRow:(NSInteger)row {
    NSLog(@"tag:%zd,row:%zd",dropListView.tag,row);
}

- (NSInteger)defaultShowRowLjbDropListView:(UIView *)dropListView {
    if (dropListView.tag == 1) {
        return 0;
    }
    return 2;
}

@end
