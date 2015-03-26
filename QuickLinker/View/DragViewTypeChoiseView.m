//
//  DragViewTypeChoiseView.m
//  QuickLinker
//
//  Created by 施杰 on 14-9-27.
//  Copyright (c) 2014年 施杰. All rights reserved.
//

#import "DragViewTypeChoiseView.h"
#import "PulsingHaloLayer.h"

@interface DragViewTypeChoiseView ()
{
    UIView *mMiddleView;
}

@end

@implementation DragViewTypeChoiseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:50.0/255.0f green:50.0/255.0f blue:50.0/255.0f alpha:0.5];
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    [self setBackgroundColor:[UIColor clearColor]];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
    
    mMiddleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width)];
    mMiddleView.backgroundColor = [UIColor whiteColor];
    
    CGFloat buttonL = self.frame.size.width / 2;
    PulsingHaloLayer *halo1 = [PulsingHaloLayer layer];
    PulsingHaloLayer *halo2 = [PulsingHaloLayer layer];
    PulsingHaloLayer *halo3 = [PulsingHaloLayer layer];
    PulsingHaloLayer *halo4 = [PulsingHaloLayer layer];
    UIButton *contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [contactButton setFrame:CGRectMake(0, 0, buttonL, buttonL)];
    [contactButton setBackgroundColor:[UIColor clearColor]];
    [contactButton setTitle:@"联系人" forState:UIControlStateNormal];
    [contactButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [contactButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    contactButton.tag = ButtonTypeContact;
    halo1.position = CGPointMake(buttonL / 2, buttonL / 2);
    [contactButton.layer insertSublayer:halo1 below:contactButton.layer];
    
    UIButton *safariButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [safariButton setFrame:CGRectMake(buttonL, 0, buttonL, buttonL)];
    [safariButton setBackgroundColor:[UIColor clearColor]];
    [safariButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [safariButton setTitle:@"Safari" forState:UIControlStateNormal];
    [safariButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    safariButton.tag = ButtonTypeSafari;
    halo2.position = CGPointMake(buttonL / 2, buttonL / 2);
    [safariButton.layer insertSublayer:halo2 below:safariButton.layer];
    
    UIButton *appButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [appButton setFrame:CGRectMake(0, buttonL, buttonL, buttonL)];
    [appButton setBackgroundColor:[UIColor clearColor]];
    [appButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [appButton setTitle:@"App" forState:UIControlStateNormal];
    [appButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    appButton.tag = ButtonTypeApp;
    halo3.position = CGPointMake(buttonL / 2, buttonL / 2);
    [appButton.layer insertSublayer:halo3 below:appButton.layer];
    
    UIButton *systemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [systemButton setFrame:CGRectMake(buttonL, buttonL, buttonL, buttonL)];
    [systemButton setBackgroundColor:[UIColor clearColor]];
    [systemButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [systemButton setTitle:@"系统" forState:UIControlStateNormal];
    [systemButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    systemButton.tag = ButtonTypeSystem;
    halo4.position = CGPointMake(buttonL / 2, buttonL / 2);
    [systemButton.layer insertSublayer:halo4 below:systemButton.layer];
    
    [mMiddleView addSubview:contactButton];
    [mMiddleView addSubview:safariButton];
    [mMiddleView addSubview:appButton];
    [mMiddleView addSubview:systemButton];
    
    [self addSubview:mMiddleView];
    [self show];
}

- (void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        [mMiddleView setFrame:CGRectMake(0, self.frame.size.height - self.frame.size.width, self.frame.size.width, self.frame.size.width)];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        [mMiddleView setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width)];
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(removeDragViewTypeChoiseView)]) {
            [self.delegate removeDragViewTypeChoiseView];
        }
    }];
}

-(void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    NSLog(@"handleTapGesture");
    [self hide];
}

- (void)buttonPressed:(UIButton*)button
{
    NSLog(@"buttonPressed");
    [self hide];
    
    if ([self.delegate respondsToSelector:@selector(choiceQuickLinkType:)]) {
        [self.delegate choiceQuickLinkType:button.tag];
    }
}

@end
