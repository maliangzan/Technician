
//
//  CustomTipsSheet.m
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "CustomTipsSheet.h"
#import "CommitSuccessTipView.h"
#import "FeedbackView.h"

#define TITLELABELHEIGHT 60

static NSString *serviceCellID = @"ServiceItemCell";
@interface CustomTipsSheet()
@property (nonatomic, strong) UIView *containerView;

@end

@implementation CustomTipsSheet

- (instancetype)initWithFrame:(CGRect)frame tipType:(SYTipType)actionType title:(NSString *)title contenViewHeight:(CGFloat)contentViewHeight{
    if (self = [super initWithFrame:frame]) {
        self.tipType = actionType;
        self.titleStr = title;
        self.contentViewHeight = contentViewHeight;
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    [self baseUI];
    
    switch (_tipType) {
        case SYTipTypeCommitSuccess:
        {
            CommitSuccessTipView *view = [[NSBundle mainBundle] loadNibNamed:@"CommitSuccessTipView" owner:nil options:nil][0];
            view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
            [self.containerView addSubview:view];
        }
            break;
            case SYTipTypeFeedback:
        {
            FeedbackView *view = [[NSBundle mainBundle] loadNibNamed:@"FeedbackView" owner:nil options:nil][0];
            view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
            [self.containerView addSubview:view];
            
        }
            break;
            
        default:
            break;
    }
    
    [self addSubview:_containerView];
}

- (void)baseUI{
    CGFloat containerViewX = 20 * kWidthFactor;
    CGFloat containerViewY = 160 * kHeightFactor;
    CGFloat containerViewW = KscreenWidth - containerViewX * 2;;
    CGFloat containerViewH;
    if (self.contentViewHeight == 0) {
        containerViewH = 200;
    }else{
        containerViewH = self.contentViewHeight;
    }
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(containerViewX,containerViewY, containerViewW, containerViewH)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 5;
    _containerView.layer.masksToBounds = YES;
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.pickerDone) {
        [self removeFromSuperview];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

@end
