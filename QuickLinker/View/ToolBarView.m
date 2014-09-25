//
//  ToolBarView.m
//  QuickLinker
//
//  Created by 施杰 on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "ToolBarView.h"

//const int ToolBarHeight = 45;
#define KPreviewColor [UIColor redColor]
//#define KPreviewButtonTag   0x101+1;
//#define KEditButtonTag      0x101+2;
//#define KSettingButtonTag   0x101+3;

@interface ToolBarView ()
@property (nonatomic, strong)NSMutableArray *mToolBarButtonArray;   // ToolBarButtonModel;
@property (nonatomic, assign)NSInteger mButtonNumber;
@end

@implementation ToolBarView

-(void)setMToolBarButtonArray:(NSMutableArray *)mToolBarButtonArray
{
    _mToolBarButtonArray = [mToolBarButtonArray mutableCopy];
    self.mButtonNumber = [_mToolBarButtonArray count];
}

// 在调用重新绘制试图前，需要先设置mToolBarButtonArray
- (void)drawRect:(CGRect)rect
{
//    UIView *view = [self.subviews]
    if (self.subviews.count != 0) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    
    if (self.mButtonNumber == 0) {
        NSLog(@"error, 传入的数量为0");
        return;
    }
    
    CGFloat wEveryButtonW = self.frame.size.width / self.mButtonNumber;
    //ToolBarButtonModel *wToolBarButtonModel in self.mToolBarButtonArray
    for (int i = 0; i < self.mButtonNumber; i++) {
        ToolBarButtonModel *wToolBarButtonModel = (ToolBarButtonModel *)[self.mToolBarButtonArray objectAtIndex:i];
        UIButton *wButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wButton setFrame:CGRectMake(wEveryButtonW * i, 0, wEveryButtonW, self.frame.size.height)];
        [wButton setBackgroundColor:[self colorWithTag:wToolBarButtonModel.tag]];
        [wButton setTitle:wToolBarButtonModel.displayName forState:UIControlStateNormal];
        [wButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [wButton setTag:wToolBarButtonModel.tag];
        [wButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:wButton];
    }
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

@end
