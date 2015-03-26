//
//  ContactTypeViewController.h
//  QuickLinker
//
//  Created by 施杰 on 14-9-27.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactTypeViewControllerProtocol;
@interface ContactTypeViewController : UIViewController

@property (nonatomic, weak) id<ContactTypeViewControllerProtocol> delegate;

@end

@protocol ContactTypeViewControllerProtocol <NSObject>

// TODO: s
-(void)tample;

@end

@interface ContactTypeModel : NSObject
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *subTitle;

@end
