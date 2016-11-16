//
//  ViewController.m
//  HLLLabel
//
//  Created by Rocky Young on 16/11/15.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"
#import "HLLLabelView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oneLineTextField;

@property (weak, nonatomic) IBOutlet UITextField *twoLineTextField;
@property (weak, nonatomic) IBOutlet UIButton *addLabelButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];

    {
        UIView * leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor clearColor];
        leftView.frame = CGRectMake(0, 0, 20, 30);
        self.oneLineTextField.leftView = leftView;
        self.oneLineTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    {
        UIView * leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor clearColor];
        leftView.frame = CGRectMake(0, 0, 20, 30);
        self.twoLineTextField.leftView = leftView;
        self.twoLineTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    self.oneLineTextField.layer.cornerRadius = 5.0f;
    self.twoLineTextField.layer.cornerRadius = 5.0f;
    
    self.oneLineTextField.layer.borderColor = [self randomColor].CGColor;
    self.twoLineTextField.layer.borderColor = [self randomColor].CGColor;
    self.oneLineTextField.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.twoLineTextField.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (UIColor *)randomColor{

    return [UIColor colorWithRed:arc4random()%255/255.0
                           green:arc4random()%255/255.0
                            blue:arc4random()%255/255.0
                           alpha:1];
}
- (IBAction)addLabelButtonHandle:(UIButton *)button{
    
    NSString * content = [NSString stringWithFormat:@"%@",self.oneLineTextField.text];
    NSString * price = [NSString stringWithFormat:@"%@",self.twoLineTextField.text];

    HLLLabelModel * model = [HLLLabelModel modelWithContent:content price:price];
    HLLLabelView * labelView = [[HLLLabelView alloc] init];
    labelView.backgroundColor = [UIColor clearColor];
    labelView.model = model;
    labelView.bounds = [model generateLabelRect];
    labelView.center = CGPointMake(100, 100);
    [self.view addSubview:labelView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [labelView addGestureRecognizer:pan];
}

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"began>>>>>>>>>");
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            NSLog(@"changed>>>>>>>>>");
            NSLog(@"%@",pan.view);
            //获取到的两个点之间的偏移量，偏移量会在以前的基础上叠加（如果偏完之后重置起点就不会偏）
            CGPoint point = [pan translationInView:pan.view];
            
            pan.view.frame = CGRectOffset(pan.view.frame, point.x, point.y);
            
            //frame设置完毕，要把起始点设置为上次拖动的结束点
            [pan setTranslation:CGPointZero inView:pan.view];
            
        }
            break;
            
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"end>>>>>>>>>");
        }
            break;
            
            
        default:
            break;
    }
    
    
}


@end
