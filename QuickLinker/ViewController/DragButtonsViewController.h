//
//  DragButtonsViewController.h
//  QuickLinker
//
//  Created by jshi.cramer on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DragButtonsViewControllerProtocol;
@interface DragButtonsViewController : UIViewController
{
    NSMutableArray *mDragButtons;       //UIDragView
    NSMutableArray *mDragButtonModels;  //DragViewModel
}
@property (nonatomic, weak) id<DragButtonsViewControllerProtocol> delegate;
-(void)reSetBgView;
- (void)enterEditMode;
- (void)enterNormalMode;
@end

@protocol DragButtonsViewControllerProtocol <NSObject>

-(void)dBVCEnterEditMode;

@end
