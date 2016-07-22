//
//  RecommendUserTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAttentionModel.h"
#define RecommendUserTableViewCell_Identify @"RecommendUserTableViewCell_Identify"
@class RecommendUserTableViewCell;
@protocol RecommendUserTableViewCellDelegate <NSObject>
-(void)recommendUserTableViewAttentionBtnClicked:(RecommendUserTableViewCell *)cell;
@end




@interface RecommendUserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *attmentionBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) NSString *cellID;
@property (weak,nonatomic) id<RecommendUserTableViewCellDelegate>delegate;

@property (strong, nonatomic) MyAttentionModel *model;
@end
