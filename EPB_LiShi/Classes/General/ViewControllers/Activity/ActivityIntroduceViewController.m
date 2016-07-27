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
#import "ItineraryTableViewCell.h"
#import "MapViewController.h"

#define DIC_EXPANDED @"expanded" //是否是展开 0收缩 1展开

#define DIC_ARARRY @"array" //存放数组

#define DIC_TITILESTRING @"title"

#define CELL_HEIGHT 50.0f

@interface ActivityIntroduceViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *routeArray;
    
}

@property(strong,nonatomic) UITableView *firstTableView;
@property(strong,nonatomic) UITableView *secondTableView;
@property(strong,nonatomic) UIScrollView *scrollView;

@property(strong,nonatomic) NSMutableArray *dataArray;

@property(strong,nonatomic) UISegmentedControl *seg;




// 具体行程页面
// 集合时间
@property(strong,nonatomic) NSString *timeString;
// 集合地点
@property(strong,nonatomic) NSString *addressString;
// 装备建议
@property(strong,nonatomic) NSString *equipadviseString;
// 费用说明
@property(strong,nonatomic) NSString *constdesString;
// 免责声明
@property(strong,nonatomic) NSString *disclaimerString;
// 注意事项
@property(strong,nonatomic) NSString *catematterString;
// 具体行程
@property(strong,nonatomic) NSString *contentString;


@end

@implementation ActivityIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    self.title = @"活动信息";
    [self requestActivityIntroduceData];
    [self segmentedControlData];
    [self requestIntroduceRouteData];
    [self initDataSource];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.seg.frame), WindownWidth, WindowHeight - CGRectGetMaxY(self.seg.frame))];
    self.scrollView.contentSize = CGSizeMake(WindownWidth * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    
    self.firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, self.scrollView.bounds.size.height)];
    self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(WindownWidth, 0, WindownWidth,self.scrollView.bounds.size.height)];
    
    [self.firstTableView registerClass:[ActivityIntroduceTableViewCell class] forCellReuseIdentifier:ActivityIntroduceTableViewCell_Identify];
    [self.secondTableView registerClass:[ItineraryTableViewCell class] forCellReuseIdentifier:ItineraryTableViewCell_Identify];
    
    
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
    self.secondTableView.delegate = self;
    self.secondTableView.dataSource = self;
    
    [self.scrollView addSubview:self.firstTableView];
    [self.scrollView addSubview:self.secondTableView];
    [self.view addSubview:self.scrollView];
    
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:236 / 255.0 blue:209 / 255.0 alpha:1];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 查找rootViewController
    self.rootVC = (RootViewController *)[[[UIApplication sharedApplication] windows] objectAtIndex:1].rootViewController;
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = NO;
}

-(void)initDataSource{
    
    routeArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *setTimeArray = [[NSMutableArray alloc] init];
    NSMutableArray *setAdressArray = [[NSMutableArray alloc] init];
    NSMutableArray *contactArray = [[NSMutableArray alloc] init];
    NSMutableArray *contentArray = [[NSMutableArray alloc] init];
    NSMutableArray *countArray = [[NSMutableArray alloc] init];
    NSMutableArray *equipadviseArray = [[NSMutableArray alloc] init];
    NSMutableArray *constdescArray = [[NSMutableArray alloc] init];
    NSMutableArray *disclaimerArray = [[NSMutableArray alloc] init];
    NSMutableArray *catematterArray= [[NSMutableArray alloc] init];
    
    [setTimeArray addObject:self.timeString];
    [setAdressArray addObject:self.addressString];
    [contentArray addObject:self.contentString];
    [equipadviseArray addObject:self.equipadviseString];
    [constdescArray addObject:self.constdesString];
    [disclaimerArray addObject:self.disclaimerString];
    [catematterArray addObject:self.catematterString];
    
    NSString *timeStr = @"集合时间";
    NSString *addressStr = @"集合地点";
    NSString *contactStr = @"联系方式";
    NSString *contentStr = @"具体行程";
    NSString *countStr = @"活动人数";
    NSString *equipadviseStr = @"装备建议";
    NSString *constdescStr = @"费用说明";
    NSString *disclaimerStr = @"免责声明";
    NSString *catematterStr = @"注意事项";
    
    NSMutableDictionary *timeDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:setTimeArray,DIC_ARARRY,timeStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *addressDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:setAdressArray,DIC_ARARRY,addressStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *contactDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:contactArray,DIC_ARARRY,contactStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:contentArray,DIC_ARARRY,contentStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *countDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:countArray,DIC_ARARRY,countStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *equipadviseDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:equipadviseArray,DIC_ARARRY,equipadviseStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *constdescDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:constdescArray,DIC_ARARRY,constdescStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *disclaimerDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:disclaimerArray,DIC_ARARRY,disclaimerStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    NSMutableDictionary *catematterDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:catematterArray,DIC_ARARRY,catematterStr,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED, nil];
    
    
    [routeArray addObject:timeDic];
    [routeArray addObject:addressDic];
    [routeArray addObject:contactDic];
    [routeArray addObject:contentDic];
    [routeArray addObject:countDic];
    [routeArray addObject:equipadviseDic];
    [routeArray addObject:constdescDic];
    [routeArray addObject:disclaimerDic];
    [routeArray addObject:catematterDic];
    
    
    
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

-(void)requestIntroduceRouteData{
    // 集合时间
    self.timeString = self.model.settime;
    NSLog(@"setString%@",self.timeString);
    // 集合地点
    self.addressString = self.model.setaddress;
    // 装备建议
    self.equipadviseString = self.model.equipadvise;
    // 费用说明
    self.constdesString = self.model.constdesc;
    // 免责声明
    self.disclaimerString = self.model.disclaimer;
    // 注意事项
    self.catematterString = self.model.catematter;
    
    NSArray *tripdetailArray = self.model.tripdetail;
    NSDictionary *tempDic = [tripdetailArray firstObject];
    self.contentString = [tempDic objectForKey:@"content"];
    NSLog(@"%@",self.contentString);
    
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
            NSLog(@"1");
            break;
            
        case 1:
            self.scrollView.contentOffset = CGPointMake(WindownWidth, 0);
            NSLog(@"2");
            [self.secondTableView reloadData];
            break;
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.firstTableView) {
        return 1;
    }else{
        NSLog(@"--------------%ld",routeArray.count);
        return routeArray.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.firstTableView) {
        return 0;
    }else{
        return 50;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        if (tableView == self.firstTableView) {
            return self.dataArray.count;
        }else{
    
            NSMutableDictionary *dic = [routeArray objectAtIndex:section];
            NSArray *array = [dic objectForKey:DIC_ARARRY];
            // 判断是收缩还是展开
            if ([[dic objectForKey:DIC_EXPANDED] intValue]) {
                return array.count;
            }else{
                return 0;
            }
            
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
        ItineraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItineraryTableViewCell_Identify];
        
        
        
        NSArray *array = [[routeArray objectAtIndex:indexPath.section] objectForKey:DIC_ARARRY];
        cell.titleLabel.frame = CGRectMake(8, 8, WindownWidth - 16, 30);
        cell.titleLabel.text = [array objectAtIndex:indexPath.row];
        
        [cell.titleLabel setNumberOfLines:0];
        [cell.titleLabel sizeToFit];
       
        
        
        NSLog(@"%-------@",cell.titleLabel.text);
        return cell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if (tableView == self.firstTableView) {
//        ActivityIntroduceModel *model = self.dataArray[indexPath.row];
//        return  [ActivityIntroduceTableViewCell cellHeight:model];
//    }else{
//        return 50;
//    }
    
    if (tableView == self.secondTableView) {
        if (indexPath.section == 0) {
            return [ItineraryTableViewCell cellHeightWithString:self.timeString];
        }else if (indexPath.section == 1){
            return [ItineraryTableViewCell cellHeightWithString:self.addressString];
        }else if (indexPath.section == 3){
            return [ItineraryTableViewCell cellHeightWithString:self.contentString];
        }else if (indexPath.section == 5){
            return [ItineraryTableViewCell cellHeightWithString:self.equipadviseString];
        }else if (indexPath.section == 6){
            return [ItineraryTableViewCell cellHeightWithString:self.constdesString];
        }else if (indexPath.section == 7){
            return [ItineraryTableViewCell cellHeightWithString:self.disclaimerString];
        }else{
            return [ItineraryTableViewCell cellHeightWithString:self.catematterString];
        }
    }else{
        
        ActivityIntroduceModel *model = self.dataArray[indexPath.row];
        return [ActivityIntroduceTableViewCell cellHeight:model];
    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.secondTableView){
        UIView *hView = [[UIView alloc]initWithFrame:CGRectMake(8,0, WindownWidth , CELL_HEIGHT)];
        
        hView.backgroundColor=[UIColor whiteColor];
        
        UIButton* eButton = [[UIButton alloc] init];
        
        //按钮填充整个视图
        eButton.frame = hView.frame;
        
        [eButton addTarget:self action:@selector(expandButtonClicked:)
         
          forControlEvents:UIControlEventTouchUpInside];
        
        //把节号保存到按钮tag，以便传递到expandButtonClicked方法
        
        eButton.tag = section;
        
        //设置图标
        
        //根据是否展开，切换按钮显示图片
        
        if ([self isExpanded:section]){
            
            [eButton setImage: [UIImage imageNamed: @"arrow_right_grey" ]forState:UIControlStateNormal];
        } else {
            
            [eButton setImage: [UIImage imageNamed: @"arrow_down_grey" ]forState:UIControlStateNormal];
        }
        //设置分组标题
        
        [eButton setTitle:[[routeArray objectAtIndex:section] objectForKey:DIC_TITILESTRING] forState:UIControlStateNormal];
        
        [eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置button的图片和标题的相对位置
        
        //4个参数是到上边界，左边界，下边界，右边界的距离
        
        eButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        
        [eButton setTitleEdgeInsets:UIEdgeInsetsMake(5,-5, 0,0)];
        
        [eButton setImageEdgeInsets:UIEdgeInsetsMake(5,self.view.bounds.size.width - 25, 0,0)];
        
        //下显示线
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, hView.frame.size.height-1, hView.frame.size.width,1)];
        
        label.backgroundColor = [UIColor grayColor];
        [hView addSubview:label];
        
        [hView addSubview: eButton];
        
        return hView;

        
    }else{
        return NULL;
    }
    
}


-(int)isExpanded:(NSInteger)section{
    
    NSDictionary *dic=[routeArray objectAtIndex:section];
    
    int expanded=[[dic objectForKey:DIC_EXPANDED] intValue];
    
    return expanded;
    
}


-(void)expandButtonClicked:(id)sender{
    
    UIButton* btn = (UIButton *)sender;
    
    NSInteger section= btn.tag;//取得tag知道点击对应哪个块
    
    [self collapseOrExpand:section];
    
    //刷新tableview
    
    [self.secondTableView reloadData];
    
}



//对指定的节进行“展开/折叠”操作,若原来是折叠的则展开，若原来是展开的则折叠

-(void)collapseOrExpand:(NSInteger)section{
    
    NSMutableDictionary *dic = [routeArray objectAtIndex:section];
    
    int expanded=[[dic objectForKey:DIC_EXPANDED] intValue];
    
    if (expanded) {
        
        [dic setValue:[NSNumber numberWithInt:0] forKey:DIC_EXPANDED];
        
    }else {
        [dic setValue:[NSNumber numberWithInt:1] forKey:DIC_EXPANDED];
    }
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityIntroduceTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView == self.secondTableView) {
        if (indexPath.section == 1) {
            MapViewController *MapVC = [MapViewController new];
            MapVC.model = self.model;
            [self.navigationController pushViewController:MapVC animated:YES];
        }
    }
    
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
