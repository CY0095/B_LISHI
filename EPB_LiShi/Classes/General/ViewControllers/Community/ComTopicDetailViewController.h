//
//  ComTopicDetailViewController.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityHeaderModel.h"
#import "RootViewController.h"
@interface ComTopicDetailViewController : UIViewController

@property (nonatomic, strong) CommunityHeaderModel *model;

@property (nonatomic, strong) RootViewController *rootVC;

@end
