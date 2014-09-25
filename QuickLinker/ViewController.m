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
@property (nonatomic, strong)ToolBarView *mToolBarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 底部工具栏
    self.mToolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KToolBarHeight, self.view.frame.size.width, KToolBarHeight)];
    
    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] initWithDisplayName:@"预览" andTag:KPreviewButtonTag];
    ToolBarButtonModel *model2 = [[ToolBarButtonModel alloc] initWithDisplayName:@"编辑" andTag:KEditButtonTag];
    ToolBarButtonModel *model3 = [[ToolBarButtonModel alloc] initWithDisplayName:@"设置" andTag:KSettingButtonTag];
    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, nil];
    
    [self.mToolBarView setMToolBarButtonArray:modelArray];
    self.mToolBarView.delegate = self;
    [self.view addSubview:self.mToolBarView];
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
            
        case KAddButtonTag:
            // TODO:
            [self gotoSettingViewController];
            return;
            break;
            
        case KOkButtonTag:
            // TODO:
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
    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] initWithDisplayName:@"预览" andTag:KPreviewButtonTag];
    ToolBarButtonModel *model2 = [[ToolBarButtonModel alloc] initWithDisplayName:@"编辑" andTag:KEditButtonTag];
    ToolBarButtonModel *model3 = [[ToolBarButtonModel alloc] initWithDisplayName:@"设置" andTag:KSettingButtonTag];
    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, nil];
    
    [self.mToolBarView setMToolBarButtonArray:modelArray];
    [self.mToolBarView setNeedsDisplay];
}

- (void)editQuickLinkers
{
    NSLog(@"editQuickLinkers");
    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] initWithDisplayName:@"预览" andTag:KPreviewButtonTag];
    ToolBarButtonModel *model2 = [[ToolBarButtonModel alloc] initWithDisplayName:@"添加" andTag:KAddButtonTag];
    ToolBarButtonModel *model3 = [[ToolBarButtonModel alloc] initWithDisplayName:@"完成" andTag:KOkButtonTag];
    ToolBarButtonModel *model4 = [[ToolBarButtonModel alloc] initWithDisplayName:@"设置" andTag:KSettingButtonTag];
    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, model4, nil];
    
    [self.mToolBarView setMToolBarButtonArray:modelArray];
    [self.mToolBarView setNeedsDisplay];
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
