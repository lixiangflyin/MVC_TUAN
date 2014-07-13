//
//  ProductSpecificationCell.h
//  TongTongTuan
//
//  Created by 李红 on 13-8-29.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductSpecificationCell;

typedef void (^AddOrSubBlock)(ProductSpecificationCell *cell);

@interface ProductSpecificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;

@property (nonatomic, copy) AddOrSubBlock addBlock, subBlock;
@end
