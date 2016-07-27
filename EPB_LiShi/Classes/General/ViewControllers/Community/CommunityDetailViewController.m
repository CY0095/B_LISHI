//
//  CommunityDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import <CoreText/CoreText.h>
#import "ComDetailFirstCell.h"
#import "CommunityDetailModel.h"
#import "CommunityDetailListModel.h"
#import "CommunityDetailRequest.h"


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CommunityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *detailTableView;

@property (nonatomic, strong) NSMutableDictionary *detailDataDic;

@property (nonatomic, strong) NSMutableArray *detaillistArray;

@end

@implementation CommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    [self.detailTableView registerNib:[UINib nibWithNibName:@"ComDetailFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ComDetailFirstCell_Identify];
    
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    
    [self.view addSubview:self.detailTableView];
    [self requestCommunityDetailData];
}

- (void)requestCommunityDetailData {
    
    self.detailDataDic = [NSMutableDictionary dictionary];
    
    __weak typeof(self) weakSelf = self;
    CommunityDetailRequest *request = [[CommunityDetailRequest alloc] init];
    NSString *topics_id = self.topics_id;
    NSString *user_id = @"451316";
    [request CommunityDetailRequestWithTopics_id:topics_id user_id:user_id success:^(NSDictionary *dic) {
        
        weakSelf.detailDataDic = [dic objectForKey:@"data"];
        
        CommunityDetailModel *headerModel = [CommunityDetailModel new];
        
        [headerModel setValuesForKeysWithDictionary:weakSelf.detailDataDic];
        NSLog(@"headerModel=====%@",headerModel);
        
        // 解析出来的是详情的列表数据
        NSArray *tempArray = [weakSelf.detailDataDic objectForKey:@"topicsdetaillist"];
        for (NSDictionary *tempDict in tempArray) {
            CommunityDetailListModel *listModel = [CommunityDetailListModel new];
            [listModel setValuesForKeysWithDictionary:tempDict];
            [weakSelf.detaillistArray addObject:listModel];
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.detailTableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 129;
//    }else {
//        return 300;
//    }
    return 129;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    CommunityDetailModel *model = [CommunityDetailModel new];
    [model setValuesForKeysWithDictionary:self.detailDataDic];
    
    ComDetailFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:ComDetailFirstCell_Identify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
    
    
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
