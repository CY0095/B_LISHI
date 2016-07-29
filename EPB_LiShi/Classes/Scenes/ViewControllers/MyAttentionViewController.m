//
//  MyAttentionViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "MyAttentionTableViewCell.h"
#import "MyAttentionRequest.h"
#import "MyAttentionModel.h"
#import "RecommendUserRequest.h"
#import "RecommendUserTableViewCell.h"
#import "AttentionRequest.h"
#import "AttentionDetailViewController.h"
@interface MyAttentionViewController ()<UITableViewDataSource,UITableViewDelegate,RecommendUserTableViewCellDelegate>
@property(strong,nonatomic)UISegmentedControl *segmented;
@property(strong,nonatomic)UITableView *MytableView;

@property(strong,nonatomic)NSMutableArray *myAttentionArray;
@property(strong,nonatomic)NSMutableArray *recommendUserArray;
@end

@implementation MyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:219/255.0 blue:195/255.0 alpha:1];
    
    self.segmented = [[UISegmentedControl alloc] initWithItems:@[@"关注",@"推荐用户"]];
    self.segmented.frame = CGRectMake(10, 70, WindownWidth - 20, WindowHeight / 20);
    [self.view addSubview:self.segmented];
    self.segmented.tintColor = [UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1];
    self.segmented.selectedSegmentIndex = 0;
    
    // 为segmented添加事件
    [self.segmented addTarget:self action:@selector(changeAttentionUser:) forControlEvents:(UIControlEventValueChanged)];
    
    
    self.MytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80 + WindowHeight / 20, WindownWidth, WindowHeight - 80 - WindowHeight / 20)];
    self.MytableView.backgroundColor = [UIColor colorWithRed:220/255.0 green:219/255.0 blue:195/255.0 alpha:1];
    self.MytableView.dataSource = self;
    self.MytableView.delegate = self;
    [self.view addSubview:self.MytableView];
    // 初始化数组
    self.myAttentionArray = [NSMutableArray array];
    self.recommendUserArray = [NSMutableArray array];
    // 注册cell
    [self.MytableView registerNib:[UINib nibWithNibName:@"MyAttentionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyAttentionTableViewCell_Identify];
    [self.MytableView registerNib:[UINib nibWithNibName:@"RecommendUserTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RecommendUserTableViewCell_Identify];
    // 请求我的关注数据
    [self requestMyAttentionData];

    

}

// segmented点击事件
-(void)changeAttentionUser:(UISegmentedControl *)segmented{
    if (segmented.selectedSegmentIndex == 0) {
        [self requestMyAttentionData];
    }else{
        [self recommendUserRequest];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = NO;
}
// 我的关注数据
-(void)requestMyAttentionData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];// 开始加载动画
    __weak typeof(self) weakSelf = self;
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    [[MyAttentionRequest shareMyAttentionRequest] myAttentRequestWithUid:uid success:^(NSDictionary *dic) {
        NSArray *lists = [[dic objectForKey:@"data"] objectForKey:@"lists"];
        [weakSelf.myAttentionArray removeAllObjects];
        for (NSDictionary *tempDic in lists) {
            MyAttentionModel *model = [MyAttentionModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.myAttentionArray addObject:model];
        }
        NSLog(@"array = %@",weakSelf.myAttentionArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.MytableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请求超时，检查网络!" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
        NSLog(@"error = %@",error);
    }];
}
// 推荐用户请求
-(void)recommendUserRequest{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];// 开始加载动画
    __weak typeof(self) weakSelf = self;
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    [[RecommendUserRequest shareRecomendUserRequest] recommendUserWithUid:uid Success:^(NSDictionary *dic) {
        NSArray *lists = [[dic objectForKey:@"data"] objectForKey:@"lists"];
        [weakSelf.recommendUserArray removeAllObjects];
        for (NSDictionary *tempDic in lists) {
            MyAttentionModel *model = [MyAttentionModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.recommendUserArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.MytableView reloadData];
            NSLog(@"array = %@",weakSelf.recommendUserArray);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"error = %@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.segmented.selectedSegmentIndex == 0) {
        return self.myAttentionArray.count;
    }else{
    return self.recommendUserArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmented.selectedSegmentIndex == 0) {
        MyAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAttentionTableViewCell_Identify];
        cell.model = self.myAttentionArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    
    RecommendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendUserTableViewCell_Identify];
        cell.delegate = self;
        cell.model = self.recommendUserArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}
// cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionDetailViewController *attentionVC = [AttentionDetailViewController new];
    MyAttentionModel *model = [[MyAttentionModel alloc] init];
    if (self.segmented.selectedSegmentIndex == 0) {
        model = self.myAttentionArray[indexPath.row];
    }else{
        model = self.recommendUserArray[indexPath.row];
    }
    attentionVC.uid = model.user_id;
    [self.navigationController pushViewController:attentionVC animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66.0;
}
#pragma mark ------ cell 上的关注按钮
// RecommendUserTableViewCell的代理方法
-(void)recommendUserTableViewAttentionBtnClicked:(RecommendUserTableViewCell *)cell{
    
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    [[AttentionRequest shareAttentionRequest] attentionRequestWithFromuid:user_id touid:cell.cellID success:^(NSDictionary *dic) {
        NSString *status = [dic objectForKey:@"status"];
        NSString *error = [[dic objectForKey:@"data"] objectForKey:@"error"];
        if ([status isEqualToString:@"OK"]) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"关注成功！" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.attmentionBtn.hidden = YES;
                });
            }];
            [alertC addAction:okaction];
            [self presentViewController:alertC animated:YES completion:nil];
        }else{
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:error preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:okaction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"连接超时！" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }];
    
    
    
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
