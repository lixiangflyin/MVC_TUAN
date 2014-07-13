//
//  CallOutAnnotationView.m
//  radio986
//
//  Created by michael_yao on 13-7-15.
//  Copyright (c) 2013年 xunao. All rights reserved.
//

#import "CallOutAnnotationView.h"
#import <QuartzCore/QuartzCore.h> 
#define  Arror_height 6 

@interface CallOutAnnotationView()
{
    UILabel *spotName, *spotAddress;
    UIButton *spotButton;
}

@end

@implementation CallOutAnnotationView
@synthesize contentView ;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        self.centerOffset = CGPointMake(0, -55);
        self.frame = CGRectMake(0, 0, 180, 50);
        
        UIView *_contentView = [[UIView alloc] initWithFrame:CGRectMake(5, 5 , self.frame.size.width-10, self.frame.size.height - 15)];
        _contentView.backgroundColor   = [UIColor clearColor];
        [self addSubview:_contentView];
        self.contentView = _contentView;
        
        spotName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width - 30, self.contentView.frame.size.height /2)];
        
        [spotName setFont:[UIFont systemFontOfSize:13]];
        [spotName setBackgroundColor:[UIColor clearColor]];
        [spotName setTextColor:[UIColor colorWithRed:61/255.0 green:72.0/255.0 blue:85.0/255.0 alpha:1]];
        [self.contentView addSubview:spotName];
        
        spotAddress = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2, self.contentView.frame.size.width - 30, self.contentView.frame.size.height / 2)];
        
        [spotAddress setBackgroundColor:[UIColor clearColor]];
        [spotAddress setTextColor:[UIColor colorWithWhite:0.5 alpha:1]];
        [spotAddress setFont:[UIFont systemFontOfSize:9]];
        [self.contentView addSubview:spotAddress];
        
        spotButton = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 30, (self.contentView.frame.size.height - 25.0)/2.0, 25, 25)];
        [spotButton setImage:[UIImage imageNamed:@"annotation_arrow"] forState:UIControlStateNormal];
        [spotButton addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:spotButton];
    }
    return self;
    
}

-(IBAction)gotoDetail:(UIButton *)sender
{
    [self.delegate performSelector:@selector(callOutClickAction:) withObject:[[NSNumber alloc] initWithInt:sender.tag]];
}

-(void)setData:(NSDictionary *)data
{
    [spotName setText:[data objectForKey:@"name"]];
    [spotAddress setText:[data objectForKey:@"address"]];
    [spotButton setTag:[[data objectForKey:@"id"] intValue]];
}

-(void)drawRect:(CGRect)rect{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    
}

-(void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    // midy = CGRectGetMidY(rrect),
    maxy = CGRectGetMaxY(rrect)-Arror_height;
    CGContextMoveToPoint(context, midx+Arror_height, maxy);
    CGContextAddLineToPoint(context,midx, maxy+Arror_height);
    CGContextAddLineToPoint(context,midx-Arror_height, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
