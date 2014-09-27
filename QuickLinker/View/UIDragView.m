//
//  UIDragView.m
//  Draging
//
//  Created by jshi.Cramer on 14-9-26.
//  Copyright (c) 2014年 jshi.Cramer. All rights reserved.
//

#import "UIDragView.h"
#import <QuartzCore/QuartzCore.h>

@interface UIDragView()
{
    // UI
    UIImageView *mLogoImageView;
    UILabel *mNameLabel;
    UIButton *mDeleteButton;
}

@property (nonatomic, assign)BOOL isDraging;

@end

@implementation UIDragView
@synthesize lastCenter;
@synthesize delegate;
@synthesize mDragViewModel;

- (instancetype)initWithFrame:(CGRect)frame andModel:(DragViewModel *)model inView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lastCenter = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
        superView = view;
        self.mDragViewModel = model;
        
        [self drawSelf];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)];
        longPress.minimumPressDuration = 1;
        [self addGestureRecognizer:longPress];
        
    }
    return self;
}

- (void)drawSelf
{
    mLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((DragViewWidth - DragImageViewL) / 2, DragMargin, DragImageViewL, DragImageViewL)];
    [mLogoImageView setImage:self.mDragViewModel.displayImage];
    mLogoImageView.layer.cornerRadius = 12;
    mLogoImageView.layer.borderWidth = 0.0;
    mLogoImageView.layer.masksToBounds = YES;
    
    mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(DragMargin, DragImageViewL + 2 * DragMargin, DragViewWidth - 2 * DragMargin, DragViewHeight - DragImageViewL - 3 * DragMargin)];
    [mNameLabel setBackgroundColor:[UIColor clearColor]];
    [mNameLabel setText:self.mDragViewModel.displayName];
    [mNameLabel setTextColor:[UIColor whiteColor]];
    [mNameLabel setTextAlignment:NSTextAlignmentCenter];
    [mNameLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    
    mDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mDeleteButton setFrame:CGRectMake(0, 0, DragViewDeleteBtnL, DragViewDeleteBtnL)];
    [mDeleteButton setBackgroundImage:[UIImage imageNamed:@"DragViewDelete.png"] forState:UIControlStateNormal];
    [mDeleteButton addTarget:self action:@selector(deleteSelf) forControlEvents:UIControlEventTouchUpInside];
    mDeleteButton.hidden = YES;
    
    [self setBackgroundColor:[UIColor clearColor]];
    // TODO: 测试范围使用，记得删除
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor blueColor].CGColor;
    
    [self addSubview:mLogoImageView];
    [self addSubview:mNameLabel];
    [self addSubview:mDeleteButton];
}

- (void)deleteSelf
{
    NSLog(@"deleteSelf");
    if ([self.delegate respondsToSelector:@selector(deleteDragView:)]) {
        [self.delegate deleteDragView:self];
    }
}

- (void)setMDVStatus:(DragViewStatus)mDVStatus
{
    if (_mDVStatus == mDVStatus) {
        return;
    }
    
    _mDVStatus = mDVStatus;
    // TODO: 修改状态时，改变界面；
    switch (mDVStatus) {
        case DragViewStatusNormal:
            mDeleteButton.hidden = YES;
            [self stopShake];
            break;
            
        case DragViewStatusEdit:
            mDeleteButton.hidden = NO;
            [self startShake];
            break;
            
        default:
            break;
    }
}

- (void)drag:(UILongPressGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:superView];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            lastPoint = point;
            if ([self.delegate respondsToSelector:@selector(enterEditMode)]) {
                [self.delegate enterEditMode];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            float offX = point.x - lastPoint.x;
            float offY = point.y - lastPoint.y;
            [self setCenter:CGPointMake(self.center.x + offX, self.center.y + offY)];
            lastPoint = point;
            if ([self.delegate respondsToSelector:@selector(checkLocationOfOthers:)]) {
                [self.delegate checkLocationOfOthers:self];
            }
            self.isDraging = YES;
            [self startDraging];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [self stopDraging];
            
            __block BOOL shouldClickAndBack = NO;
            [UIView animateWithDuration:0.5 animations:^{
                if (self.isDraging) {
                    [self setFrame:CGRectMake(lastCenter.x - DragViewWidth/2, lastCenter.y - DragViewHeight/2, DragViewWidth, DragViewHeight)];
                }else{
                    shouldClickAndBack = YES;
                }
            } completion:^(BOOL finished) {
                [self.layer setShadowOpacity:0];
                if (shouldClickAndBack) {
                    if ([self.delegate respondsToSelector:@selector(clickDragView:)]) {
                        [self.delegate clickDragView:self];
                    }
                    shouldClickAndBack = NO;
                }
            }];

            self.isDraging = NO;

            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            self.isDraging = NO;
            [self stopDraging];
            break;
        }
        case UIGestureRecognizerStateFailed:
        {
            self.isDraging = NO;
            [self stopDraging];
            break;
        }
        default:
            break;
    }
}

- (void)startDraging
{
    [self setAlpha:0.7];
}

- (void)stopDraging
{
    [self setAlpha:1];
}

#define KScaleValue  1.2
//- (void)startScale
//{
//
//}
//
//- (void)stopScale
//{
//
//}

- (void)startShake
{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.fromValue = [NSNumber numberWithFloat:-M_PI/36];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/36];
    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 0.15f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
    
    [self.layer addAnimation:rotationAnimation forKey:@"shakeAnimation"];
}

- (void)stopShake
{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
}

@end


@implementation DragViewModel

@end
