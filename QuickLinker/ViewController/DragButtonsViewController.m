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
{
    BOOL isEditing;
}

@end

@implementation DragButtonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    isEditing = NO;
    [self drawDragButtons];
    [self reSetBgView];
}

#define MaginX 8                //x坐标留白
#define MaginY 8                //y坐标留白
#define SpaceYEcahButton 0      //y坐标button间隙
#define SpaceXEcahButton (self.view.frame.size.width-2*MaginX-NumOfButtonEachRow*DragViewWidth)/(NumOfButtonEachRow+1)      //每个按钮间空隙（x坐标）
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
    
    DragViewModel *wDragButtonModel6 = [[DragViewModel alloc] init];
    wDragButtonModel6.displayImage = [UIImage imageNamed:@"6.png"];
    wDragButtonModel6.displayName = @"Calendar";
    wDragButtonModel6.displayUrl = @"12341235433";
    
//    DragViewModel *wDragButtonModel7 = [[DragViewModel alloc] init];
//    wDragButtonModel7.displayImage = [UIImage imageNamed:@"7.png"];
//    wDragButtonModel7.displayName = @"Calendar";
//    wDragButtonModel7.displayUrl = @"12341235433";
    
    DragViewModel *wDragButtonModel8 = [[DragViewModel alloc] init];
    wDragButtonModel8.displayImage = [UIImage imageNamed:@"8.png"];
    wDragButtonModel8.displayName = @"Calendar";
    wDragButtonModel8.displayUrl = @"12341235433";
    
    DragViewModel *wDragButtonModel9 = [[DragViewModel alloc] init];
    wDragButtonModel9.displayImage = [UIImage imageNamed:@"9.png"];
    wDragButtonModel9.displayName = @"Calendar";
    wDragButtonModel9.displayUrl = @"12341235433";
    
    DragViewModel *wDragButtonModel10 = [[DragViewModel alloc] init];
    wDragButtonModel10.displayImage = [UIImage imageNamed:@"10.png"];
    wDragButtonModel10.displayName = @"Calendar";
    wDragButtonModel10.displayUrl = @"12341235433";
    
    [mDragButtonModels addObject:wDragButtonModel1];
    [mDragButtonModels addObject:wDragButtonModel2];
    [mDragButtonModels addObject:wDragButtonModel3];
    [mDragButtonModels addObject:wDragButtonModel4];
    [mDragButtonModels addObject:wDragButtonModel5];
    [mDragButtonModels addObject:wDragButtonModel6];
//    [mDragButtonModels addObject:wDragButtonModel7];
    [mDragButtonModels addObject:wDragButtonModel8];
    [mDragButtonModels addObject:wDragButtonModel9];
    [mDragButtonModels addObject:wDragButtonModel10];
    
    for (int i = 0; i < [mDragButtonModels count]; i++) {
//        int row = i/NumOfButtonEachRow;//第几行
//        int col = i%NumOfButtonEachRow;//第几列
//        int orignX = MaginX + SpaceXEcahButton * (col+1) + DragViewWidth * col;
//        int orignY = MaginY + SpaceYEcahButton * (row+1) + DragViewHeight * row;
//        UIDragView *view = [[UIDragView alloc] initWithFrame:CGRectMake(orignX, orignY, DragViewWidth, DragViewHeight) andModel:[mDragButtonModels objectAtIndex:i] inView:self.view];
        UIDragView *view = [[UIDragView alloc] initWithFrame:CGRectZero andModel:[mDragButtonModels objectAtIndex:i] inView:self.view];
        [mDragButtons addObject:view];
        [view setDelegate:self];
        [view setTag:i];
        [self.view addSubview:view];
    }
    
    [self setButtonsFrameWithAnimate:NO withoutShakingButton:nil];
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

- (void)checkLocationOfOthers:(UIDragView *)dragView
{
    int indexOfDragView = 0;
    for ( int i = 0; i < [mDragButtons count]; i++) {
        if (((UIDragView *)[mDragButtons objectAtIndex:i]).tag == dragView.tag) {
            indexOfDragView = i;
            break;
        }
    }
    for (int i = 0; i < [mDragButtons count]; i++) {
        UIDragView *button = (UIDragView *)[mDragButtons objectAtIndex:i];
        if (button.tag != dragView.tag){
            CGRect shakingFrame = CGRectInset(dragView.frame, dragView.frame.size.width/4, dragView.frame.size.height/4);
            CGRect buttonFrame = CGRectInset(button.frame,dragView.frame.size.width/4, dragView.frame.size.height/4);
            if (CGRectIntersectsRect(shakingFrame, buttonFrame)) {
                DragViewModel *wModel = [mDragButtonModels objectAtIndex:indexOfDragView];
                [mDragButtonModels removeObject:wModel];
                [mDragButtonModels insertObject:wModel atIndex:i];
                
                UIDragView *wDragView = [mDragButtons objectAtIndex:indexOfDragView];
                [mDragButtons removeObject:wDragView];
                [mDragButtons insertObject:wDragView atIndex:i];
                [self setButtonsFrameWithAnimate:YES withoutShakingButton:dragView];
                break;
            }
        }
    }
}

- (void)clickDragView:(UIDragView *)dragView
{
    NSLog(@"clickDragView");
}

- (void)deleteDragView:(UIDragView *)dragView
{
    NSLog(@"deleteDragView");
    [dragView removeFromSuperview];
    
    int indexOfDragView = 0;
    for ( int i = 0; i < [mDragButtons count]; i++) {
        if (((UIDragView *)[mDragButtons objectAtIndex:i]).tag == dragView.tag) {
            indexOfDragView = i;
            break;
        }
    }
    [mDragButtonModels removeObjectAtIndex:indexOfDragView];
    [mDragButtons removeObjectAtIndex:indexOfDragView];
    [self setButtonsFrameWithAnimate:YES withoutShakingButton:nil];
}

- (void)enterEditMode
{
    if (isEditing == YES) {
        return;
    }
    for (UIDragView *wDragView in mDragButtons) {
        [wDragView setMDVStatus:DragViewStatusEdit];
    }
    if ([self.delegate respondsToSelector:@selector(dBVCEnterEditMode)]) {
        [self.delegate dBVCEnterEditMode];
    }
    isEditing = YES;
}

- (void)enterNormalMode
{
    isEditing = NO;
    for (UIDragView *wDragView in mDragButtons) {
        [wDragView setMDVStatus:DragViewStatusNormal];
    }
}


@end
