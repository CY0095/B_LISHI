//
//  ItineraryTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ItineraryTableViewCell.h"
#import "ActivityIntroduceModel.h"

@interface ItineraryTableViewCell ()

@property(strong,nonatomic) ActivityIntroduceModel *model;

@end

@implementation ItineraryTableViewCell

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
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, WindownWidth - 16, 40)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize: 13];
    [self.contentView addSubview:self.titleLabel];
}


+(CGFloat)cellHeightWithString:(NSString *)string{
    
    CGFloat staticHeight = 10;
    CGFloat dynamicHeight = [self textHeightFromString:string];
    
    return staticHeight+dynamicHeight;
}


+(CGFloat)textHeightFromString:(NSString *)string{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(WindownWidth - 16, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0]} context:nil];
    
    return  rect.size.height;
}






@end
