//
//  DragButtonsViewController.h
//  QuickLinker
//
//  Created by jshi.cramer on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragButtonsViewController : UIViewController
{
    NSMutableArray *mDragButtons;
    NSMutableArray *mDragButtonModels;
}
-(void)reSetBgView;
@end
