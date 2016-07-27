//
//  Annotation.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject<MKAnnotation>
// 经纬度
@property(nonatomic) CLLocationCoordinate2D coordinate;

@property(copy,nonatomic) NSString *title;




@end
