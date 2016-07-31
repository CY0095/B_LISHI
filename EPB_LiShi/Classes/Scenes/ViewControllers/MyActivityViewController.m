//
//  MyActivityViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/30.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MyActivityViewController.h"
#import "MyActivityCell.h"
#import "activitySingle.h"
#import "ActivityDetailViewController.h"
@interface MyActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *myActivityTableView;
@property (strong,nonatomic)NSMutableArray *dataArray;

@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tableView
    self.myActivityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, WindowHeight - 64)];
    
    self.myActivityTableView.backgroundColor = [UIColor colorWithRed:220/255.0 green:219/255.0 blue:195/255.0 alpha:1];
    self.myActivityTableView.delegate = self;
    self.myActivityTableView.dataSource = self;
    [self.view addSubview:self.myActivityTableView];
    // 注册cell
    [self.myActivityTableView registerNib:[UINib nibWithNibName:@"MyActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyActivityCell_Identify];
    // 请求数据
    [self requestData];

}
// 请求数据
-(void)requestData{
    [[activitySingle shareSingle] openDataBase];
    self.dataArray = [NSMutableArray array];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    self.dataArray = [[activitySingle shareSingle] selectFromActivityWithID:user_id];
    NSLog(@"------%@",self.dataArray);
    [[activitySingle shareSingle] closeDataBase];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:MyActivityCell_Identify];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityDetailViewController *actiVC = [[ActivityDetailViewController alloc] init];
    ActivityApplyModel *model = self.dataArray[indexPath.row];
    actiVC.DetailIDString = model.activityID;
    [self.navigationController pushViewController:actiVC animated:YES];
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
