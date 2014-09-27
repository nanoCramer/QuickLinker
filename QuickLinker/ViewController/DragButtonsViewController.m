//
//  DragButtonsViewController.m
//  QuickLinker
//
//  Created by jshi.cramer on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "DragButtonsViewController.h"
#import "UIDragView.h"

@interface DragButtonsViewController ()<UIDragViewDelegate>

@end

@implementation DragButtonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    [self drawDragButtons];
    [self reSetBgView];
}

#define MaginX 8                //x坐标留白
#define MaginY 8                //y坐标留白
#define SpaceYEcahButton 0      //y坐标button间隙
#define SpaceXEcahButton 0      //每个按钮间空隙（x坐标）
#define NumOfButtonEachRow 4    //每行最多几个按钮

- (void)drawDragButtons
{
    mDragButtons = [[NSMutableArray alloc] init];
    mDragButtonModels = [[NSMutableArray alloc] init];
    
    DragViewModel *wDragButtonModel1 = [[DragViewModel alloc] init];
    wDragButtonModel1.displayImage = [UIImage imageNamed:@"1.png"];
    wDragButtonModel1.displayName = @"Newsstand";
    wDragButtonModel1.displayUrl = @"12341235433";
    
    DragViewModel *wDragButtonModel2 = [[DragViewModel alloc] init];
    wDragButtonModel2.displayImage = [UIImage imageNamed:@"2.png"];
    wDragButtonModel2.displayName = @"Passbook";
    wDragButtonModel2.displayUrl = @"12341235433";
    
    DragViewModel *wDragButtonModel3 = [[DragViewModel alloc] init];
    wDragButtonModel3.displayImage = [UIImage imageNamed:@"3.png"];
    wDragButtonModel3.displayName = @"Settings";
    wDragButtonModel3.displayUrl = @"12341235433";
    
    DragViewModel *wDragButtonModel4 = [[DragViewModel alloc] init];
    wDragButtonModel4.displayImage = [UIImage imageNamed:@"4.png"];
    wDragButtonModel4.displayName = @"Health";
    wDragButtonModel4.displayUrl = @"12341235433";
    
    DragViewModel *wDragButtonModel5 = [[DragViewModel alloc] init];
    wDragButtonModel5.displayImage = [UIImage imageNamed:@"5.png"];
    wDragButtonModel5.displayName = @"Calendar";
    wDragButtonModel5.displayUrl = @"12341235433";
    
    [mDragButtonModels addObject:wDragButtonModel1];
    [mDragButtonModels addObject:wDragButtonModel2];
    [mDragButtonModels addObject:wDragButtonModel3];
    [mDragButtonModels addObject:wDragButtonModel4];
    [mDragButtonModels addObject:wDragButtonModel5];
    
    for (int i = 0; i < [mDragButtonModels count]; i++) {
        int row = i/NumOfButtonEachRow;//第几行
        int col = i%NumOfButtonEachRow;//第几列
        int orignX = MaginX + SpaceXEcahButton * (col+1) + DragViewWidth * col;
        int orignY = MaginY + SpaceYEcahButton * (row+1) + DragViewHeight * row;
        UIDragView *view = [[UIDragView alloc] initWithFrame:CGRectMake(orignX, orignY, DragViewWidth, DragViewHeight) andModel:[mDragButtonModels objectAtIndex:i] inView:self.view];
        [mDragButtons addObject:view];
        [view setDelegate:self];
        [view setTag:i];
        [self.view addSubview:view];
    }
    
    [self setButtonsFrameWithAnimate:NO withoutShakingButton:nil];
}

- (void)checkLocationOfOthersWithButton:(UIDragView *)shakingButton
{
    int indexOfShakingButton = 0;
    for ( int i = 0; i < [mDragButtons count]; i++) {
        if (((UIDragView *)[mDragButtons objectAtIndex:i]).tag == shakingButton.tag) {
            indexOfShakingButton = i;
            break;
        }
    }
    for (int i = 0; i < [mDragButtons count]; i++) {
        UIDragView *button = (UIDragView *)[mDragButtons objectAtIndex:i];
        if (button.tag != shakingButton.tag){
            CGRect shakingFrame = CGRectInset(shakingButton.frame, shakingButton.frame.size.width/4, shakingButton.frame.size.height/4);
            CGRect buttonFrame = CGRectInset(button.frame,shakingButton.frame.size.width/4, shakingButton.frame.size.height/4);
            if (CGRectIntersectsRect(shakingFrame, buttonFrame)) {
                UIDragView *wShakingButton = [mDragButtons objectAtIndex:indexOfShakingButton];
                [mDragButtons removeObject:wShakingButton];
                [mDragButtons insertObject:wShakingButton atIndex:i];
                [self setButtonsFrameWithAnimate:YES withoutShakingButton:shakingButton];
                break;
            }
        }
    }
}

- (void)setButtonsFrameWithAnimate:(BOOL)_bool withoutShakingButton:(UIDragView *)shakingButton
{
    NSInteger count = [mDragButtons count];
    if (shakingButton != nil) {
        if (_bool) {
            [UIView animateWithDuration:0.4 animations:^{
                for (int y = 0; y <= count / NumOfButtonEachRow; y++) {
                    for (int x = 0; x < NumOfButtonEachRow; x++) {
                        int i = NumOfButtonEachRow * y + x;
                        if (i < count) {
                            UIDragView *button = (UIDragView *)[mDragButtons objectAtIndex:i];
                            int orignX = MaginX + SpaceXEcahButton * (x+1) + DragViewWidth * x;
                            int orignY = MaginY + SpaceYEcahButton * (y+1) + DragViewHeight * y;
                            if (button.tag != shakingButton.tag) {
                                [button setFrame:CGRectMake(orignX, orignY, DragViewWidth, DragViewHeight)];
                            }
                            [button setLastCenter:CGPointMake(orignX + DragViewWidth/2, orignY + DragViewHeight/2)];
                            [self reSetBgView];
                        }
                    }
                }
            }];
        }else{
            for (int y = 0; y <= count / NumOfButtonEachRow; y++) {
                for (int x = 0; x < NumOfButtonEachRow; x++) {
                    int i = NumOfButtonEachRow * y + x;
                    if (i < count) {
                        UIDragView *button = (UIDragView *)[mDragButtons objectAtIndex:i];
                        int orignX = MaginX + SpaceXEcahButton * (x+1) + DragViewWidth * x;
                        int orignY = MaginY + SpaceYEcahButton * (y+1) + DragViewHeight * y;
                        if (button.tag != shakingButton.tag) {
                            [button setFrame:CGRectMake(orignX, orignY, DragViewWidth, DragViewHeight)];
                        }
                        [button setLastCenter:CGPointMake(orignX + DragViewWidth/2, orignY + DragViewHeight/2)];
                        [self reSetBgView];
                    }
                }
            }
        }
        
    }else{
        if (_bool) {
            [UIView animateWithDuration:0.4 animations:^{
                for (int y = 0; y <= count / NumOfButtonEachRow; y++) {
                    for (int x = 0; x < NumOfButtonEachRow; x++) {
                        int i = NumOfButtonEachRow * y + x;
                        if (i < count) {
                            UIDragView *button = (UIDragView *)[mDragButtons objectAtIndex:i];
                            int orignX = MaginX + SpaceXEcahButton * (x+1) + DragViewWidth * x;
                            int orignY = MaginY + SpaceYEcahButton * (y+1) + DragViewHeight * y;
                            [button setFrame:CGRectMake(orignX, orignY, DragViewWidth, DragViewHeight)];
                            [button setLastCenter:CGPointMake(orignX + DragViewWidth/2 , orignY + DragViewHeight/2)];
                            [self reSetBgView];
                        }
                    }
                }
            }];
        }else{
            for (int y = 0; y <= count / NumOfButtonEachRow; y++) {
                for (int x = 0; x < NumOfButtonEachRow; x++) {
                    int i = NumOfButtonEachRow * y + x;
                    if (i < count) {
                        UIDragView *button = (UIDragView *)[mDragButtons objectAtIndex:i];
                        int orignX = MaginX + SpaceXEcahButton * (x+1) + DragViewWidth * x;
                        int orignY = MaginY + SpaceYEcahButton * (y+1) + DragViewHeight * y;
                        [button setFrame:CGRectMake(orignX, orignY, DragViewWidth, DragViewHeight)];
                        [button setLastCenter:CGPointMake(orignX + DragViewWidth/2, orignY + DragViewHeight/2)];
                        [self reSetBgView];
                    }
                }
            }
        }
    }
    
    for (int i = 0; i< mDragButtons.count ; i++) {
//        UIButton *wBtn = mDragButtons[i];
//        [wBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)reSetBgView
{
    NSInteger row = mDragButtons.count / NumOfButtonEachRow;//第几行
    if (mDragButtons.count % NumOfButtonEachRow > 0) {
        row ++;
    }
    CGRect viewRect = self.view.frame;
    viewRect.size.height = row * DragViewHeight + (row + 1) * SpaceYEcahButton + 2 * MaginY;
    self.view.frame = viewRect;
}

- (void)clickButton:(UIDragView *)dragonButton
{
    NSLog(@"clickButton");
}

@end
