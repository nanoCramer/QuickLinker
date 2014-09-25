//
//  ToolBarView.h
//  QuickLinker
//
//  Created by 施杰 on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KPreviewButtonTag   (0x101+1)
#define KEditButtonTag      (0x101+2)
#define KSettingButtonTag   (0x101+3)
#define KAddButtonTag       (0x101+4)
#define KOkButtonTag        (0x101+5)


#define KRemoveButtonTag    (0x101+10)

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
