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

#define DragViewDeleteBtnL  18

typedef NS_ENUM(NSInteger, DragViewType) {
    DVTypeContactCall = 0,
    DVTypeContactMessage,
    DVTypeContactMail,
    DVTypeSafariLink,
    DVTypeAppLink,
    DVTypeSystemLink
};

typedef NS_ENUM(NSInteger, DragViewStatus) {
    DragViewStatusNormal,
    DragViewStatusEdit
};


@class UIDragView;

@protocol UIDragViewDelegate <NSObject>

- (void)checkLocationOfOthers:(UIDragView *)dragView;
- (void)clickDragView:(UIDragView *)dragView;
- (void)deleteDragView:(UIDragView *)dragView;
- (void)enterEditMode;

@end

@class DragViewModel;
@interface UIDragView : UIView
{
    UIView *superView;
    CGPoint lastPoint;
}

@property (nonatomic, assign) CGPoint lastCenter;
@property (nonatomic, weak) id<UIDragViewDelegate> delegate;
@property (nonatomic, strong) DragViewModel *mDragViewModel;
@property (nonatomic, assign) DragViewStatus mDVStatus;

- (instancetype)initWithFrame:(CGRect)frame andModel:(DragViewModel *)model inView:(UIView *)view;

- (void)startShake;
- (void)stopShake;

@end


@interface DragViewModel : NSObject
@property(nonatomic, strong)UIImage *displayImage;
@property(nonatomic, strong)NSString *displayName;
@property(nonatomic, assign)DragViewType displayType;
@property(nonatomic, strong)NSString *displayUrl;


@end
