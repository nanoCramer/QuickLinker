//
//  PreviewViewController.m
//  QuickLinker
//
//  Created by jshi.cramer on 14-9-26.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "PreviewViewController.h"
#import "MRFlipTransition.h"
#import "ToolBarView.h"

@interface PreviewViewController ()<toolBarProtocol>
@property (nonatomic, strong)ToolBarView *mToolBarView;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 底部工具栏
    self.mToolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KToolBarHeight, self.view.frame.size.width, KToolBarHeight)];
    ToolBarButtonModel *model1 = [[ToolBarButtonModel alloc] initWithDisplayName:@"取消" andTag:KCancelButtonTag];
    NSMutableArray *modelArray = [[NSMutableArray alloc] initWithObjects:model1, nil];
    [self.mToolBarView setMToolBarButtonArray:modelArray];
    self.mToolBarView.delegate = self;
    [self.view addSubview:self.mToolBarView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(MRFlipTransition *)self.transitioningDelegate updateContentSnapshot:self.view afterScreenUpdate:YES];
}

-(void)clickToolBarButton:(NSInteger)tag
{
    if (tag == KCancelButtonTag) {
        [self flyAway:nil];
    }
}

- (void)flyAway:(id)sender
{
    [(MRFlipTransition *)self.transitioningDelegate dismissTo:MRFlipTransitionPresentingFromBottom completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
