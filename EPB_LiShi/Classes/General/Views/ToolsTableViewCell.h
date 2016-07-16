//
//  ToolsTableViewCell.h
//  tools
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ToolsTableViewCell_Identify @"ToolsTableViewCell_Identify"
#import "JFModel.h"
#import "FLModel.h"

@interface ToolsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ImgView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIButton *type;

@property (strong, nonatomic) JFModel *jfmodel;
@property (strong, nonatomic) FLModel *flmodel;

@end
