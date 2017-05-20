//
//  ViewController.m
//  DFToast
//
//  Created by Fuxp on 2017/5/20.
//  Copyright © 2017年 Fuxp. All rights reserved.
//

#import "ViewController.h"
#import "DFToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showMessage:(id)sender
{
    [[DFToast defaultToast] showMessage:NSStringFromClass([sender class])];
}

@end
