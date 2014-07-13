//
//  ProductTypeCell.h
//  TongTongTuan
//
//  李红(410139419@qq.com)创建于 13-7-19.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ProductType.h"

@interface ProductTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

//- (void)updateView:(ProductType *)productType;
@end
