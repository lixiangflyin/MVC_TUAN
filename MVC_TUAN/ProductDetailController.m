//
//  ProductDetailController.m
//  MVCdemo
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProductDetailController.h"
//#import "RESTFulEngine.h"
#import "SIAlertView.h"
#import "CommentListView.h"
//#import "CommentListController.h"
//#import "ProductDetailInfoController.h"
#import "OrderController.h"
//#import "FXKeychain+User.h"
//#import "UserLoginController.h"
//#import "AppDelegate.h"

static const CGFloat lMargin = 10.0,            
                     rMargin = lMargin,
                     tMargin = 8;

@interface ProductDetailController()<UIScrollViewDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *photoAlbumImageView;

// 浮动视图区
@property (weak, nonatomic) IBOutlet UIView *floatView;
@property (weak, nonatomic) IBOutlet UILabel *costPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *notVIPPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *VIPPriceLabel;

// 简介区
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UILabel *consumerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *refundIcon1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *refundIcon2ImageView;

// 商家信息
@property (weak, nonatomic) IBOutlet UIView *merchantInfoView;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchantDistanceLabel;

// 团购详情
@property (weak, nonatomic) IBOutlet UIView *detailAboutPurchaseView;
@property (weak, nonatomic) IBOutlet UIWebView *detailAboutPurchaseWebView;
@property (weak, nonatomic) IBOutlet UIImageView *dottedLineImageView;

// 购买必知
@property (weak, nonatomic) IBOutlet UIView *importTipsView;
@property (weak, nonatomic) IBOutlet UIWebView *importTipsWebView;

// 评论列表
@property (weak, nonatomic) IBOutlet UIView *commentListView;
@property (weak, nonatomic) IBOutlet CommentListView *commentTableView;
@property (weak, nonatomic) IBOutlet UIButton *viewAllCommentButton;

@end


@implementation ProductDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)dealloc
{
    self.scrollView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    self.commentTableView.rowHeight = 60;
    
    [self.scrollView addSubview:self.descView];
    [self.scrollView addSubview:self.merchantInfoView];
    [self.scrollView addSubview:self.detailAboutPurchaseView];
    [self.scrollView addSubview:self.importTipsView];
    [self.scrollView addSubview:self.commentListView];
    
    [self.scrollView addSubview:self.floatView];
    
    [self updateViewContext];
}

//- (void)setProduct:(Product *)product
//{
//    _product = product;
//    if(product.isLoadedDetail){
//        [self updateViewContext];
//    }else{
//        [self getProductDetail];
//    }
//}

- (void)getProductDetail
{
//    [RESTFulEngine getProductDetail:self.product onSuccess:^(JSONModel *aModelBaseObject) {
//        Product *p = (Product *)aModelBaseObject;
//        [self.product copyDetailInfoToSelf:p];
//        [self updateViewContext];
//        p = nil;
//    } onError:^(NSError *engineError) {
//        NSString *reason = [NSString stringWithFormat:@"获取产品详情失败,原因:%@",[engineError localizedDescription]];
//        [SIAlertView showWithTitle:@"提示" andMessage:reason text1:@"重试" text2:@"关闭" okBlock:^{
//            [self getProductDetail];
//        } cancelBlock:^{}];
//    }];
}

#pragma makr - 

- (void)updateViewContext
{
    double price = 3.99, price_nomember = 3.99, price_member = 2.99;
    self.consumerCountLabel.text = [NSString stringWithFormat:@"%.1f元",price];
    self.notVIPPriceLable.text = [NSString stringWithFormat:@"%.1f元",price_nomember];
    self.VIPPriceLabel.text = [NSString stringWithFormat:@"%.1f元",price_member];
    
    int virtualbuy = 129;
    self.consumerCountLabel.text = [NSString stringWithFormat:@"已有%d人购买", virtualbuy];
    //self.remainingTimeLabel.text = [
    self.productNameLabel.text = @"小米手机";
    self.descLabel.text = @"高性能";
    
    self.merchantNameLabel.text = @"东南大学门店";
    self.merchantAddressLabel.text = @"四牌楼校区沙塘园";
    self.merchantDistanceLabel.text = [NSString stringWithFormat:@"%.1fkm",3.11];
    
    NSString *html = @"hello <h1>world<h1>";
    [self.detailAboutPurchaseWebView loadHTMLString:html baseURL:nil];
    [self.importTipsWebView loadHTMLString:html baseURL:nil];
    
    int comment_count = 4;
    if(comment_count == 0){
        self.viewAllCommentButton.hidden = YES;
        self.commentTableView.commentListArray = [NSArray new];
    }else{
        // 在详情界面只显示一条评论
        //self.commentTableView.commentListArray = [NSArray arrayWithObject:[self.product.commentList objectAtIndex:0]];
        //完全是测试
        self.commentTableView.commentListArray = [[NSArray alloc]initWithObjects:@"good", nil];
        [self.viewAllCommentButton setTitle:[NSString stringWithFormat:@"查看全部%d条评论",comment_count]
                                   forState:UIControlStateNormal];
    }
}

//需在WebView的代理方法-(void)webViewDidFinishLoad:中调用此方法，因为只有在WebView加载完内容后才能计算出最终WebView的高度
- (void)layoutViews
{
    // 计算团购详情况的Origin.y的值
    CGRect f1 = self.photoAlbumImageView.frame;
    CGRect f2 = self.floatView.frame;
    f2.origin.y = f1.origin.y + f1.size.height;
    self.floatView.frame = f2;
    CGRect f3 = self.descView.frame;
    f3.origin.y = f2.origin.y + f2.size.height + tMargin;
    self.descView.frame = f3;
    CGRect f4 = self.merchantInfoView.frame;
    f4.origin.y = f3.origin.y + f3.size.height + tMargin;
    self.merchantInfoView.frame = f4;
    
    
    CGFloat topMargin = self.photoAlbumImageView.bounds.size.height
                        + self.floatView.bounds.size.height
                        + self.descView.bounds.size.height
                        + self.merchantInfoView.bounds.size.height
                        + (tMargin * 3);
    CGFloat y = self.dottedLineImageView.frame.origin.y + 2 ;// 团购详情中用来展示内容的WebView的Origin.y的值
    CGFloat h;     // 经计算后WebView的高度
    if(self.detailAboutPurchaseWebView.scrollView.contentSize.height > self.detailAboutPurchaseWebView.bounds.size.height){
        h = self.detailAboutPurchaseWebView.scrollView.contentSize.height;
    }else{
        h = self.detailAboutPurchaseWebView.bounds.size.height;
    }
    
    CGRect f = self.detailAboutPurchaseView.frame;
    f.origin.y = topMargin;
    f.size.height = y + h;    // 将WebView的Origin.y的值y加上WebView本身的高度h就等于团购详情视图的高度
    self.detailAboutPurchaseView.frame = f;
    
    // 以下计算逻辑跟上面一样
    topMargin += (f.size.height + tMargin);
    if(self.importTipsWebView.scrollView.contentSize.height > self.importTipsWebView.bounds.size.height){
        h = self.importTipsWebView.scrollView.contentSize.height;
    }else{
        h = self.importTipsWebView.bounds.size.height;
    }
    f = self.importTipsView.frame;
    f.origin.y = topMargin;
    f.size.height = y + h;
    self.importTipsView.frame = f;
    
    topMargin += (f.size.height + tMargin);
    f = self.commentListView.frame;
    f.origin.y = topMargin;
    self.commentListView.frame = f;
    
    // 如果不加74,ScrollView.contentSize.height的值会过小，导致无法显示ScrollView中的所有子视图
    topMargin += (f.size.height + tMargin + 74);
    self.scrollView.contentSize = CGSizeMake(320, topMargin);
    
    NSLog(@"frame: height %f",self.scrollView.frame.size.height);
}

#pragma mark - Action
// 立即抢购
- (IBAction)buyNow:(id)sender
{
    
    OrderController *order = [[OrderController alloc]initWithNibName:@"OrderController" bundle:nil ProductT:1];
    [self.navigationController pushViewController:order animated:YES];
    return;
    
//    void (^TempBlock)(void) = ^(void){
//        OrderController *PTOC =
//        [[OrderController alloc] initWithNibName:@"OrderController" bundle:nil ProductT:self.product.pro_model];
//        [self.navigationController pushViewController:PTOC animated:YES];
//        PTOC.product = self.product;
//    };
//    
//    if([FXKeychain isUserLogin]){
//        // 用户未显示退出登陆，这里需要自动调用登陆接口以获取用户信息
//        if(GetUserInfo() == nil){
//#warning 给出等待提示
//            [RESTFulEngine userLoginWithUserName:[FXKeychain userAccount]
//                                     andPassword:[FXKeychain userPassword]
//                                       onSuccess:^(JSONModel *aModelBaseObject) {
//                                           UserLoginInfo *info = (UserLoginInfo *)aModelBaseObject;
//                                           if(info.result){
//                                               SetUserInfo(info.CustomerInfo);
//                                               TempBlock();
//                                           }else{
//                                               // 获取用户信息失败
//                                           }
//                                           
//            } onError:^(NSError *engineError) {
//                
//            }];
//        }else{
//            TempBlock();
//        }
//    }else{
//        UserLoginController *ULC =
//        [[UserLoginController alloc] initWithNibName:@"UserLoginController" bundle:nil];
//        [self presentModalViewController:ULC animated:YES];
//        ULC.loginBlock = ^(BOOL flag){
//            if(flag){
//                TempBlock();
//            }
//        };
//    }
    
    
}

// 查看所有评论
- (IBAction)viewAllComments:(id)sender
{
//    CommentListController *CLC = [[CommentListController alloc] initWithNibName:@"CommentListController" bundle:nil];
//    [self.navigationController pushViewController:CLC animated:YES];
//    CLC.commentListArray = self.product.commentList;
}

// 查看图文详情
- (IBAction)viewRichTextInfo:(id)sender
{
//    ProductDetailInfoController *PDIC = [[ProductDetailInfoController alloc] initWithNibName:@"ProductDetailInfoController"
//                                                                                      bundle:nil];
//    [self.navigationController pushViewController:PDIC animated:YES];
//    PDIC.product = self.product;
}

//查看分店
- (IBAction)viewSubbranch:(id)sender
{
    
}

// 查看地图
- (IBAction)viewProductOnMap:(id)sender
{
    
}

#pragma mark - UIScrollViewDelegate
 // any offset changes 浮动视图的调整
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"value: %f",scrollView.contentOffset.y);
    //区分对待ios6 和ios7
    if(scrollView.contentOffset.y >= self.photoAlbumImageView.bounds.size.height-64){
        NSLog(@"value: %f",scrollView.contentOffset.y);
        CGRect f = self.floatView.frame;
        //区分对待ios6 和ios7
        f.origin.y = scrollView.contentOffset.y+64;
        self.floatView.frame = f;
    }else{
        CGRect f = self.floatView.frame;
        f.origin.y = self.photoAlbumImageView.bounds.size.height;
        self.floatView.frame = f;
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    static NSUInteger count = 0;
    count++;
    if(count >= 2){ // 等待2个WebView加载完内容才重新布局子视图
        [self layoutViews];
    }
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPhotoAlbumImageView:nil];
    [self setFloatView:nil];
    [self setCostPriceLabel:nil];
    [self setNotVIPPriceLable:nil];
    [self setVIPPriceLabel:nil];
    [self setDescView:nil];
    [self setConsumerCountLabel:nil];
    [self setRemainingTimeLabel:nil];
    [self setProductNameLabel:nil];
    [self setDescLabel:nil];
    [self setRefundIcon1ImageView:nil];
    [self setRefundIcon2ImageView:nil];
    [self setMerchantInfoView:nil];
    [self setMerchantNameLabel:nil];
    [self setMerchantAddressLabel:nil];
    [self setMerchantDistanceLabel:nil];
    [self setDetailAboutPurchaseView:nil];
    [self setImportTipsView:nil];
    [self setCommentListView:nil];
    [self setDetailAboutPurchaseWebView:nil];
    [self setImportTipsWebView:nil];
    [self setDottedLineImageView:nil];
    [self setCommentTableView:nil];
    [self setViewAllCommentButton:nil];
    [super viewDidUnload];
}
@end
