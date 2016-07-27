//
//  ActivityIntroduceViewController.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailModel.h"
#import "RootViewController.h"

@interface ActivityIntroduceViewController : UIViewController

@property(strong,nonatomic) ActivityDetailModel *model;

@property (strong, nonatomic)RootViewController *rootVC;

@end
