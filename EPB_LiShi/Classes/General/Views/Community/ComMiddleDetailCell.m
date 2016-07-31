//
//  ComMiddleDetailCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ComMiddleDetailCell.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ComMiddleDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommunityHeaderModel *)model {
    
    _model = model;
    self.citynameLabel.text = model.cityname;
    self.catenameLabel.text = model.catename;
    self.createdateLabel.text = model.createdate;
    [self.initheadicon setImageWithURL:[NSURL URLWithString:model.initheadicon] placeholderImage:nil];
    self.initnickname.text = model.initnickname;
    NSArray *images = [NSArray arrayWithObjects:self.headicon_0,self.headicon_1,self.headicon_2,self.headicon_3,self.headicon_4,self.headicon_5, nil];
    NSArray *nicknames = [NSArray arrayWithObjects:self.nickname_0,self.nickname_1,self.nickname_2,self.nickname_3,self.nickname_4,self.nickname_5, nil];
    NSLog(@"%ld",model.adminlist.count);
    if (model.adminlist.count >= 6) {
        for (int i = 0; i < 6; i++) {
            [images[i] setImageWithURL:[NSURL URLWithString:[model.adminlist[i] objectForKey:@"headicon"]] placeholderImage:nil];
            [nicknames[i] setText:[model.adminlist[i] objectForKey:@"nickname"]];
        }
    }else {
        for (int i = 0; i < model.adminlist.count; i++) {
            [images[i] setImageWithURL:[NSURL URLWithString:[model.adminlist[i] objectForKey:@"headicon"]] placeholderImage:nil];
            [nicknames[i] setText:[model.adminlist[i] objectForKey:@"nickname"]];
        }
    }
    
    self.descriptLabel.text = model.descript;
}

//计算cell整体的高度
+ (CGFloat)cellHeight:(CommunityHeaderModel *)model {
    
    // cell固定部分的高度（代指实际开发中不要自适应，有固定高度的控件和间隙所共同占有高度的总和）
    CGFloat staticHeight = 414 - 136;
    // cell不固定部分的高度（需要自适应，因内容而变换的控件的高度）
    CGFloat dynamicHeight = [self textHeightFormModel:model] + WindownWidth / 10 * 3 + 16;
    // cell的高度等于固定的部分 + 变化的部分
    return staticHeight + dynamicHeight;
    
}
+ (CGFloat)textHeightFormModel:(CommunityHeaderModel *)model {
    
    CGRect rect = [model.descript boundingRectWithSize:CGSizeMake(kScreenWidth - 38, 5000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}


@end
