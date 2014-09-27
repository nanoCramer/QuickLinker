//
//  ToolBarView.m
//  QuickLinker
//
//  Created by 施杰 on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "ToolBarView.h"

@interface ToolBarView ()
@property (nonatomic, strong)NSMutableArray *mToolBarButtonArray;   // ToolBarButtonModel;
@property (nonatomic, assign)NSInteger mButtonNumber;
@end

@implementation ToolBarView

-(void)setMToolBarButtonArray:(NSMutableArray *)mToolBarButtonArray
{
    _mToolBarButtonArray = [mToolBarButtonArray mutableCopy];
    self.mButtonNumber = [_mToolBarButtonArray count];
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

// 在调用重新绘制试图前，需要先设置mToolBarButtonArray
- (void)drawRect:(CGRect)rect
{
    if (self.mButtonNumber == 0) {
        NSLog(@"error, 传入的数量为0");
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        CGAffineTransform newTRansform = CGAffineTransformMakeScale(2, 2);
        if (self.subviews.count != 0) {
            for (UIView *view in self.subviews) {
                [view setTransform:newTRansform];
                [view setAlpha:0];
                [view setTag:KRemoveButtonTag];
            }
        }
    } completion:^(BOOL finished) {
        if (self.subviews.count != 0) {
            for (UIView *view in self.subviews) {
                if (view.tag == 0) {
                    [view removeFromSuperview];
                }
            }
        }
    }];
    
    CGFloat wEveryButtonW = self.frame.size.width / self.mButtonNumber;
    for (int i = 0; i < self.mButtonNumber; i++) {
        ToolBarButtonModel *wToolBarButtonModel = (ToolBarButtonModel *)[self.mToolBarButtonArray objectAtIndex:i];
        UIButton *wButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wButton setFrame:CGRectMake(wEveryButtonW * i, self.frame.size.height, wEveryButtonW, self.frame.size.height)];
        
        [wButton setBackgroundColor:[self colorWithTag:wToolBarButtonModel.tag]];
        [wButton setTitle:wToolBarButtonModel.displayName forState:UIControlStateNormal];
        [wButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [wButton setTag:wToolBarButtonModel.tag];
        [wButton setAlpha:0];
        [wButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:wButton];
    }
    
    [UIView animateWithDuration:1 animations:^{
        if (self.subviews.count != 0) {
            for (UIView *view in self.subviews) {
                if (view.tag != KRemoveButtonTag) {
                    [view setAlpha:1];
                    CGRect viewRect = view.frame;
                    viewRect.origin.y -= viewRect.size.height;
                    view.frame = viewRect;
                }
            }
        }
    } completion:^(BOOL finished) {
    }];
}

- (UIColor *)colorWithTag:(NSInteger)tag
{
    switch (tag) {
        case KPreviewButtonTag:
            return [UIColor redColor];
            break;
        case KEditButtonTag:
            return [UIColor purpleColor];
            break;
        case KSettingButtonTag:
            return [UIColor orangeColor];
            break;
        case KAddButtonTag:
            return [UIColor blueColor];
            break;
        case KOkButtonTag:
            return [UIColor lightGrayColor];
            break;
        case KCancelButtonTag:
            return [UIColor purpleColor];
            break;
        default:
            NSLog(@"error Tag");
            break;
    }
    return [UIColor blackColor];
}

- (void)clickedButton:(UIButton *)button
{
    NSInteger tag = button.tag;
    if ([self.delegate respondsToSelector:@selector(clickToolBarButton:)]) {
        [self.delegate clickToolBarButton:tag];
    }
}

@end


@implementation ToolBarButtonModel
- (instancetype)initWithDisplayName:(NSString *)displayName andTag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.displayName = displayName;
        self.tag = tag;
    }
    return self;
}
//- (void)setDisplayName:(NSString *)displayName andTag:(NSInteger)tag
//{
//    self.displayName = displayName;
//    self.tag = tag;
//}

@end
