//
//  HLLLabelModel.h
//  HLLLabel
//
//  Created by Rocky Young on 16/11/15.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern CGFloat const kCommonHeight;
extern CGFloat const kLineHeight;
extern CGFloat const k_H_Margin;
extern CGFloat const k_V_Margin;

@interface HLLLabelModel : NSObject

@property (nonatomic ,copy) IBInspectable NSString * content;
@property (nonatomic ,copy) IBInspectable NSString * price;

@property (nonatomic ,assign ,getter=isLineTwo) BOOL lineTwo;
@property (nonatomic ,assign ,getter=isLeft) BOOL left;

- (instancetype) initWithContent:(NSString *)content price:(NSString *)price;
+ (instancetype) modelWithContent:(NSString *)content price:(NSString *)price;

/** 标签上文字的属性 */
- (NSDictionary *) attributes;

/** 整个控件的bounds */
- (CGRect) generateLabelRect;

/** 内容区域的frame */
- (CGRect) generateContentRect;
/** 价格区域的frame */
- (CGRect) generatePriceRect;

/** 根据四个点进行画线 */
- (void) drawLineWithData:(void(^)(CGPoint one_point,CGPoint two_point,CGPoint three_point,CGPoint four_point))data;
/** 根据点画中间的圆点 */
- (void) drawDotWithData:(void(^)(CGPoint point))data;
@end
