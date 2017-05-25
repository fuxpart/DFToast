//
//  DFToast.m
//  DFToast
//
//  Created by Fuxp on 2017/5/20.
//  Copyright © 2017年 Fuxp. All rights reserved.
//

#import "DFToast.h"

@implementation DFToast
{
    UIView *_view;
    UILabel *_label;
}

+ (instancetype)defaultToast
{
    static DFToast *toast;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[DFToast alloc]init];
    });
    return toast;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _view = [[UIView alloc]init];
        _view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _view.layer.cornerRadius = 5;
        _view.layer.masksToBounds = YES;
        _view.alpha = 0;
        
        _label = [[UILabel alloc]init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        
        [_view addSubview:_label];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showMessage:(NSString *)message
{
    [self showMessage:message inView:[UIApplication sharedApplication].keyWindow atPosition:DFToastPositionBottom withDuration:2];
}

- (void)showMessage:(NSString *)message atPosition:(DFToastPosition)position
{
    [self showMessage:message inView:[UIApplication sharedApplication].keyWindow atPosition:position withDuration:2];
}

- (void)showMessage:(NSString *)message atPosition:(DFToastPosition)position withDuration:(NSTimeInterval)duration
{
    [self showMessage:message inView:[UIApplication sharedApplication].keyWindow atPosition:position withDuration:duration];
}

- (void)showMessage:(NSString *)message inViewController:(UIViewController *)controller atPosition:(DFToastPosition)position withDuration:(NSTimeInterval)duration
{
    [self showMessage:message inView:controller.view atPosition:position withDuration:duration];
}

- (void)showMessage:(NSString *)message inView:(UIView *)view atPosition:(DFToastPosition)position withDuration:(NSTimeInterval)duration
{
    if (duration <= 0 || isnan(duration) || isinf(duration)) return;
    CGFloat maxWith = view.bounds.size.width - 80;
    CGFloat width = ceil([message sizeWithAttributes:@{NSFontAttributeName : _label.font}].width);
    if (width > maxWith)
    {
        width = maxWith;
    }
    _view.frame = CGRectMake(0, 0, width + 20, 40);
    switch (position)
    {
        case DFToastPositionBottom:
            _view.center = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height - 80);
            break;
        default:
            _view.center = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2);
            break;
    }
    _label.frame = CGRectMake(0, 0, width, _view.bounds.size.height);
    _label.center = CGPointMake(_view.bounds.size.width / 2, _view.bounds.size.height / 2);
    if (view == _view.superview)
    {
        [DFToast cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    }
    else
    {
        [_view removeFromSuperview];
        [view addSubview:_view];
    }
    _label.text = message;
    
    [UIView animateWithDuration:0.25 animations:^{
        _view.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:duration];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        _view.alpha = 0;
    } completion:^(BOOL finished) {
        [_view removeFromSuperview];
    }];
}

@end
