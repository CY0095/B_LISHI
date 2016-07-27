//
//  ActivityDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "DetailCycleModel.h"
#import "ActivityDetailRequest.h"
#import "ActivityDetailModel.h"
#import <SDCycleScrollView.h>
#import "ActivityModel.h"
#import "ActivityIntroduceViewController.h"
@interface ActivityDetailViewController ()<SDCycleScrollViewDelegate>

@property(strong,nonatomic) NSMutableArray *imgArr;

@property(strong,nonatomic) ActivityDetailModel *model;

@property(strong,nonatomic) UIScrollView *scrollView;

@property(strong,nonatomic) NSMutableArray *dataArray;
// 活动亮点
@property(strong,nonatomic) NSArray *lightspotArray;

@property(strong,nonatomic) NSArray *tagArray;

@property(strong,nonatomic) NSMutableArray *viewArray;

@property(strong,nonatomic) NSMutableArray *reportnoteArray;

@property(strong,nonatomic) NSString *imagesString;





@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.imgArr = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    self.lightspotArray = [NSArray array];
    self.tagArray = [NSArray array];
    self.viewArray = [NSMutableArray array];
    self.reportnoteArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:236/255.0 blue:209/255.0 alpha:1];
    
    self.model = [[ActivityDetailModel alloc] init];
    
    
    NSLog(@"88888888%@",self.DetailIDString);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 查找rootViewController
    self.rootVC = (RootViewController *)[[[UIApplication sharedApplication] windows] objectAtIndex:1].rootViewController;
    
    [self CycleDetailRequest];
    [self ActivityDetailRequest];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.rootVC.LSTabBar.hidden = NO;
    
}





-(void)CycleDetailRequest{
    
    __weak typeof(self) weakSelf = self;
    
    ActivityDetailRequest *request = [[ActivityDetailRequest alloc] init];
    
    [request ActivityDetailRequestWithUrl:ActivityDetailRequest_Url(self.DetailIDString, @"451321") Parameter:nil  success:^(NSDictionary *dic) {
        
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        NSArray *tempArr = [tempEvents objectForKey:@"activityimgs"];
        for (NSDictionary *tempDic in tempArr) {
            
            DetailCycleModel *model = [DetailCycleModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            NSURL *url = [NSURL URLWithString:model.images];
            [weakSelf.imgArr addObject:url];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        NSLog(@"activity detail = %@",weakSelf.dataArray);
        
    } failure:^(NSError *error) {
        NSLog(@"activity detail error = %@",error);
    }];
    
    
}


-(void)ActivityDetailRequest{
    
    __weak typeof(self) weakSelf = self;
    ActivityDetailRequest *request = [[ActivityDetailRequest alloc] init];
    [request ActivityDetailRequestWithUrl:ActivityDetailRequest_Url(self.DetailIDString, @"451321") Parameter:nil  success:^(NSDictionary *dic) {
        
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        [weakSelf.model setValuesForKeysWithDictionary:tempEvents];
        [weakSelf.dataArray addObject:weakSelf.model];
        
        weakSelf.lightspotArray = [tempEvents objectForKey:@"activelightspot"];
        
        weakSelf.tagArray = [tempEvents objectForKey:@"leaderdesc"];
        
        
        weakSelf.reportnoteArray = [tempEvents objectForKey:@"reportnote"];
        
        
        NSArray *tempArr = [tempEvents objectForKey:@"tripdetail"];
        NSDictionary *tempDic = [tempArr firstObject];
        weakSelf.imagesString = [tempDic objectForKey:@"images"];
        
        NSLog(@"%@",weakSelf.imagesString);
        NSLog(@"----------%@",weakSelf.lightspotArray);
        NSLog(@"%@",weakSelf.dataArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self DetailIntroduce];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}



-(void)DetailIntroduce{
    
    
    
    // 轮播图
    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WindownWidth, 245) imageURLStringsGroup:self.imgArr];
    cycle.delegate = self;
    // 轮播图所在的view
    UIView *CycleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, 300)];
    CycleView.backgroundColor = [UIColor whiteColor];
    // 轮播图标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 250, WindownWidth, 30)];
    titleLable.text = self.model.title;
    // 时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 280, 140, 20)];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = self.model.activitytimes;
    // 批次
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 280, 40, 20)];
    totalLabel.font = [UIFont systemFontOfSize:12];
    totalLabel.text = [NSString stringWithFormat:@"共%ld批",self.model.batch_total];
    // 价钱
    UILabel *constsLabel = [[UILabel alloc] initWithFrame:CGRectMake(WindownWidth - 120, 265, 100, 30)];
    constsLabel.textAlignment = NSTextAlignmentRight;
    constsLabel.text = [NSString stringWithFormat:@"￥%@起",self.model.consts];
    
    
    
    [CycleView addSubview:constsLabel];
    [CycleView addSubview:totalLabel];
    [CycleView addSubview:timeLabel];
    [CycleView addSubview:titleLable];
    [CycleView addSubview:cycle];

    
    // 活动亮点
    UILabel *titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    titleLable1.center = CGPointMake(WindownWidth / 2, 20);
    titleLable1.text = @"活动亮点";
    titleLable1.backgroundColor = [UIColor greenColor];
    titleLable1.textColor = [UIColor whiteColor];
    titleLable1.font = [UIFont systemFontOfSize:14];
    
    // 活动亮点
    UILabel *lightspotLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WindownWidth - 40, 20)];
    lightspotLabel.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(titleLable1.frame) + 10);
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int i = 0; i < self.lightspotArray.count; i++) {
        [string appendString:[NSString stringWithFormat:@"\n%@\n",self.lightspotArray[i]]];
    }
    lightspotLabel.text = string;
    
    NSLog(@"%@",lightspotLabel.text);
    NSLog(@"================%@",self.lightspotArray);
    lightspotLabel.font = [UIFont systemFontOfSize:13];
    [lightspotLabel setNumberOfLines:0];
    [lightspotLabel sizeToFit];
    
    // 查看详情
    UIButton *DetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [DetailBtn setTitle:@"   查看详情  ▷" forState:(UIControlStateNormal)];
    DetailBtn.frame = CGRectMake(0, 0, WindownWidth - 200, 40);
    DetailBtn.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(lightspotLabel.frame) + 30);
    [DetailBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [DetailBtn addTarget:self action:@selector(viewDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 组织者头像
    UIImageView *leaderImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    leaderImg.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(DetailBtn.frame) + 50);
    [leaderImg setImageWithURL:[NSURL URLWithString:self.model.leaderheadicon]];
    leaderImg.layer.cornerRadius = 32;
    leaderImg.layer.masksToBounds = YES;
    
    // 组织者昵称
    UILabel *leadernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 30)];
    leadernameLabel.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(leaderImg.frame) + 25);
    leadernameLabel.text = self.model.leadernickname;
    leadernameLabel.font = [UIFont systemFontOfSize:14];
    leadernameLabel.textAlignment = NSTextAlignmentCenter;
    
    // 组织者标签
    UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 30)];
    tagLabel.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(leadernameLabel.frame) + 25);
    NSMutableString *tagString = [[NSMutableString alloc] init];
    for (int i = 0; i < self.tagArray.count; i++) {
        [tagString appendString:[NSString stringWithFormat:@" %@ ",self.tagArray[i]]];
    }
    tagLabel.text = tagString;
    tagLabel.font = [UIFont systemFontOfSize:12];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    // 俱乐部
    UIButton *clubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clubBtn setTitle:self.model.club_title forState:UIControlStateNormal];
    clubBtn.frame = CGRectMake(0, 0, WindownWidth, 30);
    clubBtn.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(tagLabel.frame) + 25);
    [clubBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    clubBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    UIImageView *viewImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 245)];
    viewImg.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(clubBtn.frame) + 143);
    NSLog(@"***********************%@",self.viewArray);
    NSURL *url = [NSURL URLWithString:self.imagesString];
    [viewImg setImageWithURL:url];
    
    
    UILabel *signUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(viewImg.frame) + 20, 50, 20)];
    signUpLabel.text = @"报名须知";
    signUpLabel.font = [UIFont systemFontOfSize:12];
    signUpLabel.textColor = [UIColor brownColor];
    
    UILabel *applyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WindownWidth - 40, 20)];
    applyLabel.center = CGPointMake(WindownWidth / 2, CGRectGetMaxY(signUpLabel.frame) + 10);
    NSMutableString *reportnoteString = [[NSMutableString alloc] init];
    for (int i = 0 ; i < self.reportnoteArray.count; i++) {
        [reportnoteString appendString:[NSString stringWithFormat:@"\n%@\n",self.reportnoteArray[i]]];
    }
    applyLabel.text = reportnoteString;
    applyLabel.font = [UIFont systemFontOfSize:12];
    [applyLabel setNumberOfLines:0];
    [applyLabel sizeToFit];
    NSLog(@"00000000000000000000%@",applyLabel);
    
    
    UILabel *consultLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(applyLabel.frame) + 15, 50, 20)];
    consultLabel.text = @"活动咨询";
    consultLabel.font = [UIFont systemFontOfSize:12];
    consultLabel.textColor = [UIColor brownColor];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"免费咨询电话400-672-8099(工作日9:00-18:00)"];
    UILabel *counselLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(consultLabel.frame) + 10, WindownWidth - 40, 20)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(6, 12)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 33)];
    counselLabel.attributedText = str;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 374, WindownWidth, CGRectGetMaxY(counselLabel.frame) + 60)];
    view.backgroundColor = [UIColor whiteColor];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, WindowHeight)];
    self.scrollView.contentSize = CGSizeMake(WindownWidth, CGRectGetMaxY(view.frame)+30);
    
    
    
    
    [view addSubview:counselLabel];
    [view addSubview:consultLabel];
    [view addSubview:applyLabel];
    [view addSubview:signUpLabel];
    [view addSubview:viewImg];
    [view addSubview:clubBtn];
    [view addSubview:tagLabel];
    [view addSubview:leadernameLabel];
    [view addSubview:leaderImg];
    [view addSubview:titleLable1];
    [view addSubview:lightspotLabel];
    [view addSubview:DetailBtn];
    
    
    
    
    [self.scrollView addSubview:view];
    [self.scrollView addSubview:CycleView];
    [self.view addSubview:self.scrollView];
}



-(void)viewDetailClick:(UIButton *)btn{
    
    ActivityIntroduceViewController *introducnVC = [ActivityIntroduceViewController new];
    
    introducnVC.model = self.model;
    
    NSLog(@"%@",introducnVC.model);
    
    [self.navigationController pushViewController:introducnVC animated:YES];
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
