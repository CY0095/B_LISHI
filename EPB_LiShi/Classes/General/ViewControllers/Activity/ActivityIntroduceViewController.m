//
//  ActivityIntroduceViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ActivityIntroduceViewController.h"
#import "ActivityIntroduceModel.h"
#import "ActivityIntroduceTableViewCell.h"

@interface ActivityIntroduceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *firstTableView;
@property(strong,nonatomic) UITableView *secondTableView;
@property(strong,nonatomic) UIScrollView *scrollView;

@property(strong,nonatomic) NSMutableArray *dataArray;

@property(strong,nonatomic) UISegmentedControl *seg;

@end

@implementation ActivityIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    self.title = @"活动信息";
    [self requestActivityIntroduceData];
    [self segmentedControlData];
    
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.seg.frame), WindownWidth, WindowHeight - CGRectGetMaxY(self.seg.frame))];
    self.scrollView.contentSize = CGSizeMake(WindownWidth * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    
    self.firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, self.scrollView.bounds.size.height)];
    self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(WindownWidth, 0, WindownWidth,self.scrollView.bounds.size.height)];
    
    [self.firstTableView registerClass:[ActivityIntroduceTableViewCell class] forCellReuseIdentifier:ActivityIntroduceTableViewCell_Identify];
    [self.secondTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"bbb"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
    self.secondTableView.delegate = self;
    self.secondTableView.dataSource = self;
    
    [self.scrollView addSubview:self.firstTableView];
    [self.scrollView addSubview:self.secondTableView];
    [self.view addSubview:self.scrollView];
    
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:236 / 255.0 blue:209 / 255.0 alpha:1];
    
    
}

-(void)requestActivityIntroduceData{
    
    for (NSDictionary *tempDic in self.model.activitydetail) {
        ActivityIntroduceModel *model = [[ActivityIntroduceModel alloc] init];
        [model setValuesForKeysWithDictionary:tempDic];
        [self.dataArray addObject:model];
        NSLog(@"%@",model.content);
    }
    NSLog(@"%@",self.dataArray);
    
}






-(void)segmentedControlData{
    
    NSArray *array = @[@"活动介绍",@"具体行程"];
    self.seg = [[UISegmentedControl alloc] initWithItems:array];
    self.seg.frame = CGRectMake(0, 74, WindownWidth, 65);
    
    self.seg.tintColor = [UIColor whiteColor];
    self.seg.selectedSegmentIndex = 0;
    self.seg.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:236 / 255.0 blue:209 / 255.0 alpha:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],UITextAttributeTextColor,[UIFont fontWithName:@"SnellRoundhand-Bold" size:14],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextShadowColor, nil];
    [self.seg setTitleTextAttributes:dic forState:UIControlStateNormal];
    // 自动为内容分配所占区域大小
    self.seg.apportionsSegmentWidthsByContent = YES;
    // 添加方法
    [self.seg addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.seg];
    
}


-(void)changePage:(UISegmentedControl *)seg{
    
    switch ([seg selectedSegmentIndex]) {
        case 0:
            self.scrollView.contentOffset = CGPointMake(0, 0);
            break;
            
        case 1:
            self.scrollView.contentOffset = CGPointMake(WindownWidth, 0);
            break;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.firstTableView) {
        return self.dataArray.count;
    }else{
        return 9;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == self.firstTableView) {
        
        ActivityIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityIntroduceTableViewCell_Identify];
        
        ActivityIntroduceModel *model = self.dataArray[indexPath.row];
        cell.model = model;
        
        cell.titleLabel.frame = CGRectMake(8, 8, WindownWidth - 16, 20);
        [cell.titleLabel setNumberOfLines:0];
        [cell.titleLabel sizeToFit];
        cell.introduceImgView.frame = CGRectMake(0, CGRectGetMaxY(cell.titleLabel.frame) + 5, WindownWidth, WindownWidth * 3 / 4);
        
        return cell;
        
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bbb"];
        cell.detailTextLabel.text = @"bbb";
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.firstTableView) {
        ActivityIntroduceModel *model = self.dataArray[indexPath.row];
        return  [ActivityIntroduceTableViewCell cellHeight:model];
    }
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityIntroduceTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
