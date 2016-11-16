//
//  HLLLabelModel.m
//  HLLLabel
//
//  Created by Rocky Young on 16/11/15.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLLabelModel.h"

CGFloat const kCommonHeight = 20.0f;
CGFloat const kLineHeight = 1.0f;
CGFloat const k_H_Margin = 8.0f;
CGFloat const k_V_Margin = 10.0f;

@implementation HLLLabelModel

- (instancetype) initWithContent:(NSString *)content price:(NSString *)price{

    self = [super init];
    if (self) {
        
        _left = YES;
        _content = content;
        _price = price;
        [self generateLabelRect];
    }
    return self;
}
+ (instancetype) modelWithContent:(NSString *)content price:(NSString *)price{

    return [[self alloc]initWithContent:content price:price];
}

- (NSDictionary *)attributes{

    static NSDictionary * att;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSShadow * shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        shadow.shadowOffset = CGSizeMake(1, 1);
        shadow.shadowBlurRadius = 2.0f;
        att = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                NSForegroundColorAttributeName:[UIColor whiteColor],
                NSShadowAttributeName:shadow};
    });
    
    return att;
}

- (CGRect)generateLabelRect{

    CGSize contentSize = CGSizeZero;
    CGSize priceSize = CGSizeZero;
    CGFloat height = 0.0f;
    CGFloat width = 0.0f;
    
    if (![self.content isEqualToString:@""] && self.content.length) {
        contentSize = [self.content sizeWithAttributes:self.attributes];
        height += (kCommonHeight + kLineHeight );
    }
    if (![self.price isEqualToString:@""] && self.price.length) {
        priceSize = [self.price sizeWithAttributes:self.attributes];
        height += (kCommonHeight + kLineHeight);
    }
    height += (4 + k_V_Margin);
    self.lineTwo = height >= 2 * (kCommonHeight + kLineHeight);

    if (!self.isLineTwo) {
        height -= k_V_Margin;
    }
    
    CGFloat maxWidth = contentSize.width >= priceSize.width ? contentSize.width : priceSize.width;
    
    width = k_H_Margin * 2 + maxWidth;
    
    return (CGRect){CGPointZero,{width,height}};
}

- (CGRect) generateContentRect{

    CGSize contentSize = CGSizeZero;

    if (![self.price isEqualToString:@""] && self.price.length) {
        contentSize = [self.price sizeWithAttributes:self.attributes];
    }
    if (![self.content isEqualToString:@""] && self.content.length) {
        contentSize = [self.content sizeWithAttributes:self.attributes];
    }
    CGFloat x = 0.0f;
    if (self.isLeft) {
        x = k_H_Margin;
    }else{
        x = CGRectGetWidth(self.generateLabelRect) - contentSize.width - k_H_Margin;
    }
    return (CGRect){CGPointMake(x ,0),{contentSize.width + k_H_Margin / 2, contentSize.height}};
}

- (CGRect) generatePriceRect{

    CGSize priceSize = CGSizeZero;
    CGFloat y = self.isLineTwo ? kCommonHeight + kLineHeight + k_V_Margin : 0.0f;
    
    if (![self.price isEqualToString:@""] && self.price.length) {
        priceSize = [self.price sizeWithAttributes:self.attributes];
    }
    
    CGFloat x = 0.0f;
    if (self.isLeft) {
        x = k_H_Margin;
    }else{
        x = CGRectGetWidth(self.generateLabelRect) - priceSize.width - k_H_Margin;
    }
    return (CGRect){CGPointMake(x ,y), {priceSize.width + k_H_Margin / 2,priceSize.height}};
}


- (void) drawLineWithData:(void(^)(CGPoint one_point,CGPoint two_point,CGPoint three_point,CGPoint four_point))data{

    CGPoint one_point = CGPointZero;
    CGPoint two_point = CGPointZero;
    CGPoint three_point = CGPointZero;
    CGPoint four_point = CGPointZero;
    
    if (self.isLeft) {

        one_point = CGPointMake(k_H_Margin + CGRectGetWidth(self.generateContentRect), kCommonHeight + kLineHeight);
        two_point = CGPointMake(k_H_Margin / 2, kCommonHeight + kLineHeight);
        three_point = CGPointMake(k_H_Margin / 2, kCommonHeight * 2 + kLineHeight + k_V_Margin);
        four_point = CGPointMake(k_H_Margin + CGRectGetWidth(self.generatePriceRect), kCommonHeight * 2 + kLineHeight + k_V_Margin);
    }else{
    
        one_point = CGPointMake(CGRectGetWidth(self.generateLabelRect) - CGRectGetWidth(self.generateContentRect) - k_H_Margin, kCommonHeight + kLineHeight);
        two_point = CGPointMake(CGRectGetWidth(self.generateLabelRect) - k_H_Margin / 2, kCommonHeight + kLineHeight);
        three_point = CGPointMake(CGRectGetWidth(self.generateLabelRect) - k_H_Margin / 2, kCommonHeight * 2 + kLineHeight + k_V_Margin);
        four_point = CGPointMake(CGRectGetWidth(self.generateLabelRect) - CGRectGetWidth(self.generatePriceRect) - k_H_Margin * 3 / 2, kCommonHeight * 2 + kLineHeight + k_V_Margin);
    }
    if (!self.isLineTwo) {
        three_point = two_point;
        four_point = two_point;
    }
    if (data) {
        
        data(one_point,two_point,three_point,four_point);
    }
}

- (void) drawDotWithData:(void(^)(CGPoint point))data{

    CGPoint point = CGPointZero;
    CGFloat point_x = 0.0f;
    CGFloat point_y = 0.0f;
    
    if (self.isLeft) {
        
        point_x =k_H_Margin / 2;
        
        if (!self.isLineTwo) {
            point_y = kCommonHeight + kLineHeight;
        }else{
            point_y = k_V_Margin / 2 + kCommonHeight * 3 / 2 + kLineHeight;
        }
    }else{
    
        point_x = CGRectGetWidth([self generateLabelRect])  - k_H_Margin / 2;
        
        if (!self.isLineTwo) {
            point_y = kCommonHeight + kLineHeight;
        }else{
            point_y = k_V_Margin / 2 + kCommonHeight * 3 / 2 + kLineHeight;
        }
    }
    
    point = CGPointMake(point_x, point_y);
    
    if (data) {
        
        data(point);
    }
}
@end
