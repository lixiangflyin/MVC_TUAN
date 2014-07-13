//
//  OrderController.h
//  TongTongTuan
//
//  Created by 李红 on 13-8-26.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import "BaseController.h"
//#import "Product.h"

typedef enum{
    ProductTProduct = 1,   // 产品类
    ProductTService,       // 服务类
    ProductTDiscountCoupon // 优惠券
}ProductT;  //产品类型，此枚举类型值应跟Product.pro_model定义的值对应

// 商品类订单
@interface OrderController : BaseController
//@property (nonatomic, strong) Product *product;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
          ProductT:(ProductT)type;

- (void)setProduct;
@end
