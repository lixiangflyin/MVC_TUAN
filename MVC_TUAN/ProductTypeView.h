//
//  ProduceTypeView.h
//  MVC_TUAN
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductTypeDelegate

-(void)setCategory:(int)category withName:(NSString *)categoryName;

@end

@interface ProductTypeView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *typeData;
@property(nonatomic, weak) id<ProductTypeDelegate> delegate;
@property int selectType;

@end
