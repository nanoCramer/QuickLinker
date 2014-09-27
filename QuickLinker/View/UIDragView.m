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
        longPress.minimumPressDuration = 0.01;
        [self addGestureRecognizer:longPress];
        
    }
    return self;
}

- (void)drawSelf
{
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blueColor].CGColor;
    
    UIImageView *wImageView = [[UIImageView alloc] initWithFrame:CGRectMake((DragViewWidth - DragImageViewL) / 2, DragMargin, DragImageViewL, DragImageViewL)];
    [wImageView setImage:self.mDragViewModel.displayImage];
    wImageView.layer.cornerRadius = 12;
    wImageView.layer.borderWidth = 0.0;
    wImageView.layer.masksToBounds = YES;
    [self addSubview:wImageView];
    
    UILabel *wNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(DragMargin, DragImageViewL + 2 * DragMargin, DragViewWidth - 2 * DragMargin, DragViewHeight - DragImageViewL - 3 * DragMargin)];
    [wNameLabel setBackgroundColor:[UIColor clearColor]];
    [wNameLabel setText:self.mDragViewModel.displayName];
    [wNameLabel setTextColor:[UIColor whiteColor]];
    [wNameLabel setTextAlignment:NSTextAlignmentCenter];
    [wNameLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [self addSubview:wNameLabel];
}

- (void)drag:(UILongPressGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:superView];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self setAlpha:0.7];
            lastPoint = point;
            [self.layer setShadowColor:[UIColor grayColor].CGColor];
            [self startShake];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            float offX = point.x - lastPoint.x;
            float offY = point.y - lastPoint.y;
            [self setCenter:CGPointMake(self.center.x + offX, self.center.y + offY)];
            lastPoint = point;
            [delegate checkLocationOfOthersWithButton:self];
            self.isDraging = YES;
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [self stopShake];
            [self setAlpha:1];
            
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
                    [delegate clickButton:self];
                    shouldClickAndBack = NO;
                }
            }];

            self.isDraging = NO;

            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            self.isDraging = NO;
            [self stopShake];
            [self setAlpha:1];
            break;
        }
        case UIGestureRecognizerStateFailed:
        {
            self.isDraging = NO;
            [self stopShake];
            [self setAlpha:1];
            break;
        }
        default:
            break;
    }
}


- (void)startShake
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    shakeAnimation.duration = 0;
    shakeAnimation.autoreverses = YES;
    shakeAnimation.repeatCount = MAXFLOAT;
    shakeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -0.01, 0, 0, 0)];
    shakeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, 0.01, 0, 0, 0)];
    
    [self.layer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}

- (void)stopShake
{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
}

@end


@implementation DragViewModel

@end
