#import <UIKit/UIKit.h>

@interface ZPPopupView : UIView
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation ZPPopupView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
        self.layer.cornerRadius = 16;
        self.layer.masksToBounds = YES;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, frame.size.width-40, 40)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.text = @"温馨提示";
        [self addSubview:_titleLabel];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeButton.frame = CGRectMake(frame.size.width/2-50, 80, 100, 40);
        [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
    }
    return self;
}

- (void)show {
    self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIWindow *targetWindow = nil;
        if (@available(iOS 13.0, *)) {
            for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    targetWindow = [(UIWindowScene *)scene windows].firstObject;
                    break;
                }
            }
        } else {
#if defined(ROOTLESS) && ROOTLESS
            targetWindow = [[UIApplication sharedApplication] windows].firstObject;
#else
            targetWindow = [[UIApplication sharedApplication].windows firstObject];
#endif
        }
        
        if (targetWindow) {
            ZPPopupView *alert = [[ZPPopupView alloc] initWithFrame:CGRectMake(0, 0, 280, 160)];
            
            CGFloat statusBarHeight = 0;
            if (@available(iOS 13.0, *)) {
                statusBarHeight = targetWindow.windowScene.statusBarManager.statusBarFrame.size.height;
            } else if (@available(iOS 2.0, *)) {
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
                #pragma clang diagnostic pop
            }
            
            CGFloat topMargin = statusBarHeight + 20;
            CGFloat alertWidth = 300;
            alert.frame = CGRectMake((targetWindow.bounds.size.width - alertWidth)/2, 
                                   topMargin,
                                   alertWidth,
                                   160);
            
            if (@available(iOS 11.0, *)) {
                alert.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
            }
            [targetWindow addSubview:alert];
            [alert show];
        }
    });
}
%end 