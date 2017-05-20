//
//  DFToast.h
//  DFToast
//
//  Created by Fuxp on 2017/5/20.
//  Copyright © 2017年 Fuxp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DFToastPosition) {
    DFToastPositionBottom,
    DFToastPositionCenter
};

@interface DFToast : NSObject

+ (instancetype)defaultToast;

- (void)showMessage:(NSString *)message;
- (void)showMessage:(NSString *)message atPosition:(DFToastPosition)position;
- (void)showMessage:(NSString *)message atPosition:(DFToastPosition)position withDuration:(NSTimeInterval)duration;
- (void)showMessage:(NSString *)message inViewController:(UIViewController *)controller atPosition:(DFToastPosition)position withDuration:(NSTimeInterval)duration;

@end
