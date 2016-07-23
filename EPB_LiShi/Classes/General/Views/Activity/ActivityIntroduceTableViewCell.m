//
//  ActivityIntroduceTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ActivityIntroduceTableViewCell.h"

@implementation ActivityIntroduceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawView];
    }
    return self;
}
-(void)drawView{
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, WindownWidth - 16, 20)];
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    
    self.titleLabel.textColor = [UIColor blackColor];
    
    
    [self.contentView addSubview:self.titleLabel];
    
    self.introduceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 10, WindownWidth, WindownWidth * 3 / 4)];
    [self.contentView addSubview:self.introduceImgView];
    
}


-(void)setModel:(ActivityIntroduceModel *)model{
    
    _model = model;
    
    self.titleLabel.text = model.content;
    
    
    
    
    [self.introduceImgView setImageWithURL:[NSURL URLWithString:model.images]];
    
}


+(CGFloat)cellHeight:(ActivityIntroduceModel *)model{
    
    
    CGFloat staticHeight = 20;
    CGFloat dynamicHeight = [self textHeightFromMode:model] + WindownWidth * 3 /4;
    
    return staticHeight + dynamicHeight;
}


+(CGFloat)textHeightFromMode:(ActivityIntroduceModel *)model{
    
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(WindownWidth - 16, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0]} context:nil];
    
    return  rect.size.height;
}







@end
