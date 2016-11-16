//
//  HLLLabelView.h
//  HLLLabel
//
//  Created by Rocky Young on 16/11/15.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLLabelModel.h"

@interface HLLLabelView : UIView

@property (nonatomic ,strong) IBOutlet HLLLabelModel * model;

- (void) responseTapHandle:(void (^)(BOOL isLeft))action;
@end
