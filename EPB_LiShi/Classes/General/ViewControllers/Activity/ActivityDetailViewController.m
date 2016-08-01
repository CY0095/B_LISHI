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
#import <UMSocial.h>
#import "GiFHUD.h"
#import "activitySingle.h"
#import "ActivityApplyModel.h"
#import "LoginViewController.h"
#import "AttentionDetailViewController.h"
#import "ComTopicDetailViewController.h"
@interface ActivityDetailViewController ()<SDCycleScrollViewDelegate,UMSocialUIDelegate>

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
    
    [GiFHUD setGifWithImageName:@"load.gif"];
    [GiFHUD show];
    
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(returnLastPage)];
    
    // 查找rootViewController
    self.rootVC = (RootViewController *)[[[UIApplication sharedApplication] windows] objectAtIndex:1].rootViewController;
    
    
    [self ActivityDetailRequest];
    [self shareNavigationItem];
}

-(void)returnLastPage{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)shareNavigationItem{
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = share;
    
}







-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.rootVC.LSTabBar.hidden = NO;
    
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
        
        
        NSArray *photoArr = [tempEvents objectForKey:@"activityimgs"];
        for (NSDictionary *tempDic in photoArr) {
            
            DetailCycleModel *model = [DetailCycleModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            NSURL *url = [NSURL URLWithString:model.images];
            [weakSelf.imgArr addObject:url];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self DetailIntroduce];
            [GiFHUD dismiss];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

-(void)shareAction{
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.imagesString];
    [UMSocialData defaultData].extConfig.title = self.model.title;
    [UMSocialData defaultData].extConfig.qqData.url = self.imagesString;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5795790567e58eb0bc00128f"
                                      shareText:self.model.title
                                     shareImage:[UIImage imageNamed:@""]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
    
    [UMSocialData defaultData].extConfig.qqData.title = self.model.title;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.imagesString;
    [UMSocialData defaultData].extConfig.qzoneData.title = self.model.title;
    
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
    leaderImg.userInteractionEnabled = YES;
    // 添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JumpToUser)];
    [leaderImg addGestureRecognizer:tap];
    
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
    [clubBtn addTarget:self action:@selector(JumpToClub) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    
    UILabel *counselLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(consultLabel.frame)+10, 72, 20)];
    counselLabel.text = @"免费咨询电话";
    counselLabel.font = [UIFont systemFontOfSize:12];
    
    
    UIButton *counselButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [counselButton setTitle:@"400-672-8099" forState:UIControlStateNormal];
    [counselButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    counselButton.frame = CGRectMake(CGRectGetMaxX(counselLabel.frame)+1, CGRectGetMaxY(consultLabel.frame) + 10, 87, 20);
    counselButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [counselButton addTarget:self action:@selector(usePhone:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *counselLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(counselButton.frame)+1, CGRectGetMaxY(consultLabel.frame) + 10, 109, 20)];
    counselLabel2.text = @"(工作日9:00-18:00)";
    counselLabel2.font = [UIFont systemFontOfSize:12];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 374, WindownWidth, CGRectGetMaxY(counselLabel.frame) + 60)];
    view.backgroundColor = [UIColor whiteColor];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, WindowHeight)];
    self.scrollView.contentSize = CGSizeMake(WindownWidth, CGRectGetMaxY(view.frame)+30);
    
    
    
    
    [view addSubview:counselLabel2];
    [view addSubview:counselButton];
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
    
    
    UIView *applyView = [[UIView alloc] initWithFrame:CGRectMake(0, WindowHeight - 40, WindownWidth, 40)];
    applyView.backgroundColor = [UIColor colorWithRed:114/255.0 green:226/255.0 blue:115/255.0 alpha:0.7];
    
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyBtn setTitle:@"我要报名" forState:UIControlStateNormal];
    applyBtn.frame = CGRectMake(0, 0, WindownWidth, 40);
    applyBtn.center = CGPointMake(WindownWidth / 2, 20);
    [applyBtn addTarget:self action:@selector(applyAction:) forControlEvents:UIControlEventTouchUpInside];
    [applyView addSubview:applyBtn];
    
    [self.view addSubview:applyView];
    
}

-(void)JumpToUser{
    
    NSLog(@"pppppppppppp%@",self.model.leader_userid);
    
    AttentionDetailViewController *attentionVC = [AttentionDetailViewController new];
    
    attentionVC.uid = self.model.leader_userid;
    
    [self.navigationController pushViewController:attentionVC animated:YES];
    
    
}

-(void)JumpToClub{
    
    NSLog(@"%@",self.model.club_id);
    ComTopicDetailViewController *comtopVC = [ComTopicDetailViewController new];
    
    comtopVC.model.club_id = self.model.club_id;
    
    
    [self.navigationController pushViewController:comtopVC animated:YES];
}


-(void)applyAction:(UIButton *)btn{
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    if (!user_id) {
        NSLog(@"没登录");
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有登录" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"去登录" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }];
        [alertC addAction:okaction];
        
        [self presentViewController:alertC animated:YES completion:^{
            
        }];

    }else{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确认报名" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        BOOL isequel = NO;
       // BOOL isApply = NO;
//        for (NSDictionary *detailDic in [activitySingle shareSingle].activityArray) {
//            NSString * detailID = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"detailID"]];
//            if ([detailID isEqualToString:[NSString stringWithFormat:@"%@",self.DetailIDString]]) {
//                isApply = YES;
//            }
//            NSLog(@"-----%ld",[activitySingle shareSingle].activityArray.count);
//            NSLog(@"+++++++++++++++++++++++++++++++%@",[activitySingle shareSingle].activityArray);
        
        activitySingle *single = [activitySingle shareSingle];
        // 打开数据库
        [single openDataBase];
        
        
        
//        }
        
        
        NSArray *dataArray = [single selectFromStudent];
        for (ActivityApplyModel *model in dataArray) {
            if ([model.activityID isEqualToString:[NSString stringWithFormat:@"%@",self.DetailIDString]]) {
                isequel = YES;
            }
            NSLog(@"----------------------%@",model.activityID);
        }
        NSLog(@"----------------------%@",self.DetailIDString);
        
        if (isequel == YES) {
            
            UIAlertController *judgeController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已报名,无需重新报名" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [judgeController addAction:OKAction];
            [self presentViewController:judgeController animated:YES completion:nil];
            
        }else{
            [single creatTable];
            [single insertActivityDEtailWithID:self.DetailIDString title:self.model.title imagesString:self.imagesString user_id:user_id];
            
            UIAlertController *applyController = [UIAlertController alertControllerWithTitle:nil message:@"报名成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [applyController addAction:determineAction];
            [self presentViewController:applyController animated:YES completion:nil];
            
        }
        
        
        [single closeDataBase];
        NSString *as = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSLog(@"%@",as);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:OKAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    }
}





-(void)usePhone:(UIButton *)btn{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否拨打电话" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:@"tel://4006728099"]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
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
