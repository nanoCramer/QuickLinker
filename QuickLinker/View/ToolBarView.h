//
//  ToolBarView.h
//  QuickLinker
//
//  Created by 施杰 on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KPreviewButtonTag   (1001)
#define KEditButtonTag      (1002)
#define KSettingButtonTag   (1003)
#define KAddButtonTag       (1004)
#define KOkButtonTag        (1005)
#define KCancelButtonTag    (1006)

#define KRemoveButtonTag    (1010)

#define KToolBarHeight 45


@protocol toolBarProtocol;
@interface ToolBarView : UIView
@property (nonatomic, weak)id<toolBarProtocol>delegate;

-(void)setMToolBarButtonArray:(NSMutableArray *)mToolBarButtonArray;

@end

@protocol toolBarProtocol <NSObject>

-(void)clickToolBarButton:(NSInteger)tag;

@end

@interface ToolBarButtonModel : NSObject
@property (nonatomic, strong)NSString *displayName;
@property (nonatomic, assign)NSInteger tag;

- (instancetype)initWithDisplayName:(NSString *)displayName andTag:(NSInteger)tag;
//- (void)setDisplayName:(NSString *)displayName andTag:(NSInteger)tag;

@end
