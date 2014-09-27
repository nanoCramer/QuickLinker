//
//  ViewController.m
//  QuickLinker
//
//  Created by 施杰 on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "ViewController.h"
#import "ToolBarView.h"
#import "MRFlipTransition.h"
#import "PreviewViewController.h"
#import "SettingViewController.h"
#import "DragButtonsViewController.h"

@interface ViewController ()<toolBarProtocol>
@property (nonatomic, strong)ToolBarView *mToolBarView;
@property (nonatomic, strong)MRFlipTransition *previewAnimator;
@property (nonatomic, strong)MRFlipTransition *settingAnimator;
@property (nonatomic, strong)DragButtonsViewController *mDragButtonsVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 按钮组件框
    self.mDragButtonsVC = [[DragButtonsViewController alloc] init];
    [self.mDragButtonsVC.view setFrame:CGRectMake(0, 20, self.view.frame.size.width, 200)];
    [self.mDragButtonsVC reSetBgView];
    [self.view addSubview:self.mDragButtonsVC.view];
    
    // 底部工具栏
    self.mToolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KToolBarHeight, self.view.frame.size.width, KToolBarHeight)];
    
    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] initWithDisplayName:@"预览" andTag:KPreviewButtonTag];
    ToolBarButtonModel *model2 = [[ToolBarButtonModel alloc] initWithDisplayName:@"编辑" andTag:KEditButtonTag];
    ToolBarButtonModel *model3 = [[ToolBarButtonModel alloc] initWithDisplayName:@"设置" andTag:KSettingButtonTag];
    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, nil];
    
    [self.mToolBarView setMToolBarButtonArray:modelArray];
    self.mToolBarView.delegate = self;
    [self.view addSubview:self.mToolBarView];
    
    // 页面跳转
    self.previewAnimator = [[MRFlipTransition alloc] initWithPresentingViewController:self];
    self.settingAnimator = [[MRFlipTransition alloc] initWithPresentingViewController:self];
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
            [self pressedAddButton];
            return;
            break;
            
        case KOkButtonTag:
            // TODO:
            [self pressedOkButton];
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
    PreviewViewController *controller = [[PreviewViewController alloc] initWithNibName:nil bundle:nil];
    [self.previewAnimator present:controller from:MRFlipTransitionPresentingFromInfinityAway completion:nil];
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
    SettingViewController *controller = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
    [self.settingAnimator present:controller from:MRFlipTransitionPresentingFromInfinityAway completion:nil];
    //    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] initWithDisplayName:@"预览" andTag:KPreviewButtonTag];
    //    ToolBarButtonModel *model2 = [[ToolBarButtonModel alloc] initWithDisplayName:@"编辑" andTag:KEditButtonTag];
    //    ToolBarButtonModel *model3 = [[ToolBarButtonModel alloc] initWithDisplayName:@"设置" andTag:KSettingButtonTag];
    //    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, nil];
    //
    //    [self.mToolBarView setMToolBarButtonArray:modelArray];
    //    [self.mToolBarView setNeedsDisplay];
}

- (void)pressedAddButton
{
    NSLog(@"pressedAddButton");
    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] initWithDisplayName:@"预览" andTag:KPreviewButtonTag];
    ToolBarButtonModel *model2 = [[ToolBarButtonModel alloc] initWithDisplayName:@"编辑" andTag:KEditButtonTag];
    ToolBarButtonModel *model3 = [[ToolBarButtonModel alloc] initWithDisplayName:@"设置" andTag:KSettingButtonTag];
    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, model2, model3, nil];
    
    [self.mToolBarView setMToolBarButtonArray:modelArray];
    [self.mToolBarView setNeedsDisplay];
}

- (void)pressedOkButton
{
    NSLog(@"pressedOkButton");
    [self pressedAddButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
