//
//  DetailsViewController.h
//  MyProject
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 刘亚彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityListModel.h"
@interface DetailsViewController : UIViewController

@property (strong, nonatomic) CommunityListModel *model;

@property (strong, nonatomic) NSString *tempUrl;

@end
