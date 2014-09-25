//
//  ViewController.m
//  QuickLinker
//
//  Created by 施杰 on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "ViewController.h"
#import "ToolBarView.h"

const int KToolBarHeight = 45;

@interface ViewController ()<toolBarProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 底部工具栏
    ToolBarView *wToolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KToolBarHeight, self.view.frame.size.width, KToolBarHeight)];
    
    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] init];
    model1.displayName = @"预览";
    model1.tag = KPreviewButtonTag;
    ToolBarButtonModel *model2 = [[ToolBarButtonModel alloc] init];
    model2.displayName = @"编辑";
    model2.tag = KEditButtonTag;
    ToolBarButtonModel *model3 = [[ToolBarButtonModel alloc] init];
    model3.displayName = @"设置";
    model3.tag = KSettingButtonTag;
    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, nil];
    
    [wToolBarView setMToolBarButtonArray:modelArray];
    wToolBarView.delegate = self;
    [self.view addSubview:wToolBarView];
}

// toolBarProtocol
-(void)clickToolBarButton:(NSInteger)tag
{
    switch (tag) {
        case KPreviewButtonTag:
            [self previewTodayExView];
            return;
            break;
            
        case KEditButtonTag:
            [self editQuickLinkers];
            return;
            break;
            
        case KSettingButtonTag:
            [self gotoSettingViewController];
            return;
            break;
            
        default:
            break;
    }
}

// toolBar action
- (void)previewTodayExView
{
    NSLog(@"previewTodayExView");
}

- (void)editQuickLinkers
{
    NSLog(@"editQuickLinkers");
}

- (void)gotoSettingViewController
{
    NSLog(@"gotoSettingViewController");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
