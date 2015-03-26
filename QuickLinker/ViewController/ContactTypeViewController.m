//
//  ContactTypeViewController.m
//  QuickLinker
//
//  Created by 施杰 on 14-9-27.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "ContactTypeViewController.h"
#import "MRFlipTransition.h"
#import "ToolBarView.h"

@interface ContactTypeViewController ()<toolBarProtocol, UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mTableView;
}
@property (nonatomic, strong)ToolBarView *mToolBarView;
@property (nonatomic, strong)NSMutableArray *mContactModelArray;

@end

@implementation ContactTypeViewController

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
    
//    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20 - KToolBarHeight)];
//    mTableView.delegate = self;
//    mTableView.dataSource = self;
//    [self.view addSubview:mTableView];
    
    ContactTypeModel *wModel1 = [[ContactTypeModel alloc] init];
    wModel1.image = [UIImage imageNamed:@"1.png"];
    wModel1.title = @"电话";
    wModel1.subTitle = @"通过QuickLinker给某人打电话";
    
    ContactTypeModel *wModel2 = [[ContactTypeModel alloc] init];
    wModel2.image = [UIImage imageNamed:@"2.png"];
    wModel2.title = @"短信";
    wModel2.subTitle = @"通过QuickLinker给某人发短信";
    
    ContactTypeModel *wModel3 = [[ContactTypeModel alloc] init];
    wModel3.image = [UIImage imageNamed:@"3.png"];
    wModel3.title = @"邮件";
    wModel3.subTitle = @"通过QuickLinker给某人发邮件";
    
    self.mContactModelArray = [[NSMutableArray alloc] initWithObjects:wModel1, wModel2, wModel3, nil];
    
    CGFloat tableViewHeight = self.mContactModelArray.count * 60;
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 20 - KToolBarHeight - tableViewHeight) / 2, self.view.frame.size.width, tableViewHeight)];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.view addSubview:mTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(MRFlipTransition *)self.transitioningDelegate updateContentSnapshot:self.view afterScreenUpdate:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
    }
    ContactTypeModel *model = [self.mContactModelArray objectAtIndex:[indexPath row]];
    cell.textLabel.text = model.title;
    cell.imageView.image = model.image;
    cell.detailTextLabel.text = model.subTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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



@implementation ContactTypeModel

@end
