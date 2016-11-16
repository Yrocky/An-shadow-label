//
//  HLLLabelView.m
//  HLLLabel
//
//  Created by Rocky Young on 16/11/15.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLLabelView.h"

@interface HLLLabelView ()

@property (nonatomic ,copy) void(^TapHandle) (BOOL isLeft);

@end
@implementation HLLLabelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defatulSetup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defatulSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defatulSetup];
    }
    return self;
}

- (void)awakeFromNib{

    [super awakeFromNib];
    
    [self defatulSetup];
}

- (void) defatulSetup{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabelHandle:)];
    [self addGestureRecognizer:tap];
}

- (void) tapLabelHandle:(UITapGestureRecognizer *)tapGesture{
    
    self.model.left = ! self.model.isLeft;
    
    [self setNeedsDisplay];
    
    if (self.TapHandle) {
        
        self.TapHandle(self.model.isLeft);
    }
}


- (void) responseTapHandle:(void (^)(BOOL isLeft))action{
    
    self.TapHandle = action;
}


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    hll_drawLabelInContext(self.model.content,self.model.generateContentRect,self.model.attributes);
    
    hll_drawLabelInContext(self.model.price,self.model.generatePriceRect,self.model.attributes);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.model drawLineWithData:^(CGPoint one_point, CGPoint two_point, CGPoint three_point, CGPoint four_point) {
       
        hll_drawLineWithContext(context, one_point, two_point, three_point, four_point);
    }];
    
    [self.model drawDotWithData:^(CGPoint point) {
       
        hll_drawDotWithContext(context,point);
    }];
}
void hll_drawLabelInContext(NSString * text,CGRect rect ,NSDictionary *attributres){
    
    UILabel * rowLabel = [[UILabel alloc] init];
    
    rowLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributres];
    
    [rowLabel drawTextInRect:rect];
};

void hll_drawLineWithContext(CGContextRef context, CGPoint r_t_point, CGPoint l_t_point, CGPoint l_b_point, CGPoint r_b_point){
    
    CGPoint lines[] = {
        r_t_point,
        l_t_point,
        l_b_point,
        r_b_point
    };
    CGContextAddLines(context, lines, sizeof(lines)/sizeof(lines[0]));
    CGContextSetLineWidth(context, kLineHeight);
    CGContextSetShadowWithColor(context, CGSizeMake(1, 1), 2, [UIColor colorWithWhite:0.1 alpha:0.5].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextStrokePath(context);
};

void hll_drawDotWithContext(CGContextRef context, CGPoint point){
    
    CGContextAddArc(context, point.x, point.y, 3, 0, M_PI * 2, 1);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.5 alpha:0.5].CGColor);
    
    CGContextFillPath(context);
    
    CGContextAddArc(context, point.x, point.y, 1.5f, 0, M_PI * 2, 1);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextFillPath(context);
};
@end
