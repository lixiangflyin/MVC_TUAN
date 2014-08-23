//
//  ProductSubTypeCell.h
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ProductType.h"

@interface ProductSubTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

//- (void)updateView:(ProductType *)productType;

@end
