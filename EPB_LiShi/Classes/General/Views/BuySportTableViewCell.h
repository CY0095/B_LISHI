//
//  BuySportTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//
@class BuySportTableViewCell;
#import <UIKit/UIKit.h>
#define buySportViewCell_Identify @"buySportViewCell_Identify"
#import "BuySportModel.h"

@protocol buySportDelegate <NSObject>

- (void)backButtonClick:(BuySportTableViewCell *)cell;

@end

@protocol shareSportDelegate <NSObject>

- (void)shareButtonClick:(BuySportTableViewCell *)cell;

@end

@interface BuySportTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) NSString *share_url;


@property (strong, nonatomic) BuySportModel *model;
@property (weak, nonatomic) id<buySportDelegate> delegate;
@property (weak, nonatomic) id<shareSportDelegate> shareDelegate;

@end
