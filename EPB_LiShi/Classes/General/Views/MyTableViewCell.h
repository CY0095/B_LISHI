//
//  MyTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MyTableViewCell_Identify @"MyTableViewCell_Identify"
@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;

@end
