//
//  CityListController.h
//  TongTongTuan
//
//  李红(410139419@qq.com)创建于 13-7-22.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "BaseController.h"

@protocol CityListControllerDelegate;

@interface CityListController : BaseController
@property (nonatomic, weak) id<CityListControllerDelegate> delegate;

// 将定位得到的城市名称添加到城市列表中“定位城市”的Section中
- (void)setLocationCtiy:(NSDictionary *)cityDic;
@end


@protocol CityListControllerDelegate <NSObject>

//这种方式还没用过
@required
- (void)cityListController:(CityListController *)controller cityDicationary:(NSDictionary *)cityDicationary;
@end