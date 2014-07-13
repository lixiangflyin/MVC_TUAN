//
//  OrderController.m
//  TongTongTuan
//
//  Created by 李红 on 13-8-26.
//  Copyright (c) 2013年 贵阳世纪恒通科技有限公司. All rights reserved.
//

#import "OrderController.h"
#import "ProductSpecificationCell.h"
//#import "ProductSpecification.h"
//#import "UserInfo.h"
//#import "FXKeychain+User.h"
//#import "AppDelegate.h"
#import "SIAlertView.h"
#import "LHActionView.h"
#import "UIScrollView+ContentSize.h"

AddOrSubBlock addBlock, subBlock;

@interface OrderController ()<UITableViewDataSource,UITableViewDelegate>

//购买产品信息
@property (weak, nonatomic) IBOutlet UIView      *containerView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel     *productNameLabel;

//送递详细信息
@property (weak, nonatomic) IBOutlet UIView      *containerView2;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;        
@property (weak, nonatomic) IBOutlet UILabel     *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel     *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel     *zipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel     *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipsTextField;
@property (strong, nonatomic) IBOutlet UIView    *inputAccessoryView;

@property (weak, nonatomic) IBOutlet UIView      *containerView3;
@property (weak, nonatomic) IBOutlet UIImageView *refundImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *refundImageView2;

//绑定电话号码
@property (weak, nonatomic) IBOutlet UIView  *containerView4;
@property (weak, nonatomic) IBOutlet UILabel *bindphoneNumberLabel;

// 发货时间,默认为1。此属性值的含义由Logistics.recive_mode字段定义
@property (assign, nonatomic) NSInteger deliveryTime;
@property (assign, nonatomic) NSInteger numberOfRow;
@property (assign, nonatomic) NSInteger sum; //购买商品总数
//@property (strong, nonatomic) UserInfo  *userInfo;
@property (assign, nonatomic) BOOL      tableViewFirstReloadData;
@property (assign, nonatomic) CGPoint   contentOffsetBeforeKeyboardShow; //启动键盘的位置
@property (assign, nonatomic) ProductT  productType;
@end


@implementation OrderController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
          ProductT:(ProductT)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        if(type <= 0 || type > 3){
            //[SIAlertView showWithMessage:@"抱歉😭，系统发生错误(产品类型参数有误)" text1:@"关闭" okBlock:^{}];
            return nil;
        }
        
        self.title = @"提交订单";
        self.sum = 1;
        self.deliveryTime = 1;
        self.productType = type;
        
        // 增加购买商品数量
        addBlock = ^(ProductSpecificationCell *cell){
            // 购买商品总数大于此商品限够个数
            // 注:pay_max为0代表不限制购买数量
            int pay_max = 5;
            if(pay_max != 0 && self.sum >= pay_max){
                NSString *message = [NSString stringWithFormat:@"此商品最多只允许购买%ld个", (long)self.sum];
                [SIAlertView showWithMessage:message text1:@"关闭" okBlock:^{}];
                return;
            }
            
            NSInteger i =  cell.quantityTextField.text.integerValue;
            
            //ProductSpecification *ps = self.product.prospecs[cell.tag];
            int kucun_max = 15;
            if(i < kucun_max){ // 每个规格商品的购买数必须小于此规格商品的库存数
                i++;
                self.sum++;
                cell.quantityTextField.text = [NSString stringWithFormat:@"%ld",(long)i];
                
                [self.tableView reloadData];
            }else{
                NSString *message = [NSString stringWithFormat:@"此规格的产品最多只能购买%d个",kucun_max];
                [SIAlertView showWithMessage:message text1:@"关闭" okBlock:^{}];
            }
        };
        
        // 减少购买商品数量
        subBlock = ^(ProductSpecificationCell *cell){
            if(self.sum == 1){
                //[SIAlertView showWithMessage:@"至少必须选择一个商品🎁" text1:@"关闭" okBlock:^{}];
                return;
            }
            
            NSInteger i =  cell.quantityTextField.text.integerValue;
            if(i > 0){
                i--;
                self.sum--;
                cell.quantityTextField.text = [NSString stringWithFormat:@"%ld",(long)i];
                cell.leftButton.enabled = YES;
                if(i == 0){ // 此规格的商品数少于
                    cell.leftButton.enabled = NO;
                }
                
                [self.tableView reloadData];
            }
        };
        
        // 订阅键盘出现和隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView1];
    [self.view addSubview:self.containerView2];
    [self.view addSubview:self.containerView3];
    [self.view addSubview:self.containerView4];
    //更新UI
    [self setProduct];
    
    self.containerView4.hidden = (self.productType == ProductTProduct);
    self.containerView2.hidden = (self.productType != ProductTProduct);
    self.containerView2.tag = 888;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductSpecificationCell" bundle:nil]
         forCellReuseIdentifier:@"ProductSpecificationCell"];
    
    self.tipsTextField.inputAccessoryView = self.inputAccessoryView;
    
    //用户信息
    //self.userInfo = GetUserInfo();
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 必须在这里重新设置此属性的值到YES
    self.tableViewFirstReloadData = YES;
    [self.tableView reloadData];
}


//- (void)setProduct:(Product *)product
- (void)setProduct
{
    //_product = product;

    if(self.productType == ProductTProduct){
        self.numberOfRow = 4 + 3; // 4为必须出现的表单元数量,包括单价，小计，运费，总价
    }else if(self.productType == ProductTService) {
        self.numberOfRow = 2 + 2; // 2为必须出现的表单元，包括单价，总价
    }else{
        self.numberOfRow = 3;                          // 3位必须出现的表单元，包括单价，数量，总价
        self.sum = 1;  // 若为优惠券订单，那么商品数量为产品规格的数量
    }
    
    [self.tableView reloadData];
    
    self.productNameLabel.text = @"小米手机";
    self.nameLabel.text = @"李翔";
    self.phoneNumberLabel.text = @"18795867287";
    self.bindphoneNumberLabel.text = @"18795867287";
    self.addressLabel.text = @"江苏省东南大学四牌楼校区砂糖园2号";
    self.zipCodeLabel.text = @"310018";
    
    // 延迟执行，否则有可能出现在tableView没有完成加载列表之前就开始进行界面的布局,导致界面布局不正确(因为此时还不知道
    // tableView的高度)
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self layoutUI];
    });
}

- (void)layoutUI
{
    CGRect f1 = self.containerView1.frame;
    CGSize size = self.tableView.contentSize;  //获取刷新后的tableview的长高
    f1.size.height = size.height + 29;  // 29为tableView顶部与容器1的间距
    self.containerView1.frame = f1;

    #define Margin 8   //容器与容器间的差距
    
    CGRect f2;
    if(self.productType == ProductTProduct){
        f2 = self.containerView2.frame;
        f2.origin.y = f1.origin.y + f1.size.height + Margin; // 8为容器1和容器2之前的间距
        self.containerView2.frame = f2;
    }else{
        f2 = self.containerView4.frame;
        f2.origin.y = f1.origin.y + f1.size.height + Margin;
        // 容器2比容器4高度高，这样在调用setScrollViewContentSize:计算UIScrollView的高度时会
        // 得出错误得结果，因为此时容器2时隐藏状态，不应该将其高度加进来。所以根据setScrollViewContentSize:
        // 中的算法，这里把容器而的bounds值设为0，这样就可忽略掉容器2了。
        self.containerView2.frame = CGRectZero;
        self.containerView4.frame = f2;
    }
    
    CGRect f3 = self.containerView3.frame;
    f3.origin.y = f2.origin.y + f2.size.height + Margin;
    self.containerView3.frame = f3;
    
    UIScrollView *scrollView = (UIScrollView *)self.view;
    [UIScrollView setScrollViewContentSize:scrollView];
    //这句话我没理解
    if(scrollView.bounds.size.height == scrollView.contentSize.height){
        scrollView.scrollEnabled = NO;
    }

}


// 选择收货日期
- (IBAction)selectReceiptDateLabel:(id)sender
{
   __block NSArray *ds = @[@"只送工作日",@"只双休日、假日送货",@"白天没人，其他时间送货",@"工作日、双休日与假日均可送货"];
   [LHActionView showInView:self.view.superview dataSource:ds callbackBlock:^(NSInteger rowIndex) {
       self.dateLabel.text = ds[rowIndex];
       self.deliveryTime = rowIndex + 1;
       ds = nil; 
   }];
}

// 提交订单
- (IBAction)submitOrder:(id)sender
{
    
}

// 绑定新号
- (IBAction)bindNewPhoneNumber:(id)sender
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    NSInteger i;
    // i值的是根据产品原型的界面来计算的。比如优惠券只需显示单价，数量，总价，那么i值为3(此时self.numberOfRow为3)后
    // if(indexPath.row > 0 && indexPath.row < self.numberOfRow - i) 这个表达
    // 的结果就为假,就不会向界面中添加改变产品规格的UI组件
    if(self.productType == ProductTProduct){
        i = 3;
    }else if(self.productType == ProductTService) {
        i = 1;
    }else{
        i = 3;
    }
   
    if(indexPath.row > 0 && indexPath.row < self.numberOfRow - i){
        ProductSpecificationCell *pcell = [self.tableView
                                           dequeueReusableCellWithIdentifier:@"ProductSpecificationCell"];
        pcell.addBlock = addBlock;
        pcell.subBlock = subBlock;
        
        // 产品规格视图从1开始，所以这里需要减1
        NSInteger i = indexPath.row - 1;
        
        //产品的种类
        //ProductSpecification *ps = self.product.prospecs[i];
        pcell.tag = i;  // 在addBlock和subBlock里面将使用此值来访问self.product.prospecs[i];
        if(self.productType == ProductTProduct){
            pcell.nameLabel.text = @"统一为绿色";
        }else{
            pcell.nameLabel.text = @"数量:";
        }
        
        NSInteger q = pcell.quantityTextField.text.integerValue;
        // 如果表视图第一载入数据,就将第一个规格的产品购买数量设置为1
        // 以后对每种规格的产品的购买数量进行增减都会导致表视图重载入数据
        if(self.tableViewFirstReloadData && i == 0){
            if(q == 0){
                q = 1;
            }
            self.tableViewFirstReloadData = NO;
        }
        pcell.quantityTextField.text = [NSString stringWithFormat:@"%ld", (long)q];
        pcell.leftButton.enabled = (q == 0 ? NO : YES);
        cell = pcell;
        
    }else{
        static NSString *identifier = @"cellIdentifier";
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:identifier];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        CGFloat price;
        int user_type = 2;
        double postage = 5;
        if(user_type > 1){ // 会员
            price = 2.99;
        }else{  // 普通会员(注册了，但没交钱开通的账户)
            price = 3.99;
        }
        
        if(self.productType == ProductTProduct){ // 产品类商品
            if(indexPath.row == 0){
                cell.textLabel.text = @"单价:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f",price];
            }else if(indexPath.row == self.numberOfRow - 3){
                cell.textLabel.text = @"小计:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f", self.sum * price];
            }else if(indexPath.row == self.numberOfRow - 2){
                cell.textLabel.text = @"运费:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f",postage];
            }else if(indexPath.row == self.numberOfRow - 1){
                // 总价=购买商品数量 x 单价 - 邮费
                CGFloat p = (self.sum * price) + postage;
                cell.textLabel.text = @"总价:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f", p];
            }
            
        }else if(self.productType == ProductTService){ // 服务类商品
            if(indexPath.row == 0){
                cell.textLabel.text = @"单价:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f",price];
            }else if(indexPath.row == self.numberOfRow - 1){
                CGFloat p = (self.sum * price) + postage;
                cell.textLabel.text = @"总价:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f", p];
            }
            
        }else{  // 优惠券
            if(indexPath.row == 0){
                cell.textLabel.text = @"单价:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f",price];
            }else if(indexPath.row == 1){
                cell.textLabel.text = @"数量:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)self.sum];
            }else if(indexPath.row == 2){
                CGFloat p = (self.sum * price);
                cell.textLabel.text = @"总价:";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.1f", p];
            }

        }
    }
    
    return cell;
}

#pragma mark Responding to keyboard events

- (void)keyboardWillShow:(NSNotification *)notification
{
    // 获取键盘Frame
    NSDictionary *userInfo = [notification userInfo];
//    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
   
    // 获取键盘的动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
     // 调整UI元素的位置
    [UIView animateWithDuration:animationDuration animations:^{
        UIScrollView *scrollView = (UIScrollView *)self.view;
        CGPoint offset = scrollView.contentOffset;
        self.contentOffsetBeforeKeyboardShow = offset;
        offset.y += 100;
        scrollView.contentOffset = offset;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        UIScrollView *scrollView = (UIScrollView *)self.view;
        scrollView.contentOffset = self.contentOffsetBeforeKeyboardShow;
    }];
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.view endEditing:YES];
}


- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setPhoneNumberLabel:nil];
    [self setAddressLabel:nil];
    [self setZipCodeLabel:nil];
    [self setDateLabel:nil];
    [self setRefundImageView1:nil];
    [self setRefundImageView2:nil];
    [self setTableView:nil];
    [self setContainerView1:nil];
    [self setContainerView2:nil];
    [self setProductNameLabel:nil];
    [self setInputAccessoryView:nil];
    [self setContainerView3:nil];
    [self setContainerView4:nil];
    [self setBindphoneNumberLabel:nil];
    [super viewDidUnload];
}
@end
