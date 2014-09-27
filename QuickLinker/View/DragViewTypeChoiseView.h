//
//  DragViewTypeChoiseView.h
//  QuickLinker
//
//  Created by 施杰 on 14-9-27.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonType) {
    ButtonTypeContact = 0,
    ButtonTypeSafari,
    ButtonTypeApp,
    ButtonTypeSystem
};

@protocol DragViewTypeChoiseViewProtocol;
@interface DragViewTypeChoiseView : UIView

@property (nonatomic, weak) id<DragViewTypeChoiseViewProtocol> delegate;

@end

@protocol DragViewTypeChoiseViewProtocol <NSObject>

-(void)removeDragViewTypeChoiseView;
-(void)choiceQuickLinkType:(ButtonType)type;

@end
