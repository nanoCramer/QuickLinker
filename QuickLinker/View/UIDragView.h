//
//  UIDragView.h
//  Draging
//
//  Created by jshi.Cramer on 14-9-26.
//  Copyright (c) 2014年 jshi.Cramer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define DragViewWidth   76
#define DragViewHeight  84
#define DragImageViewL  60
#define DragMargin      4


@class UIDragView;

@protocol UIDragViewDelegate <NSObject>

- (void)checkLocationOfOthersWithButton:(UIDragView *)shakingButton;
- (void)clickButton:(UIDragView *)dragonButton;//点击上侧按钮，保存返回，显示该tab页面；

@end

@class DragViewModel;
@interface UIDragView : UIView
{
    UIView *superView;
    CGPoint lastPoint;
}

@property (nonatomic, assign) CGPoint lastCenter;
@property (nonatomic, assign) id<UIDragViewDelegate> delegate;
@property (nonatomic, strong) DragViewModel *mDragViewModel;

- (instancetype)initWithFrame:(CGRect)frame andModel:(DragViewModel *)model inView:(UIView *)view;

- (void)startShake;
- (void)stopShake;

@end


@interface DragViewModel : NSObject
@property(nonatomic, strong)UIImage *displayImage;
@property(nonatomic, strong)NSString *displayName;
//@property(nonatomic, assign)类型
@property(nonatomic, strong)NSString *displayUrl;


@end
