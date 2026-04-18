#import <UIKit/UIKit.h>

// ドラッグ移動を可能にするためのインターフェース宣言
@interface DraggableButton : UIButton
@end

@implementation DraggableButton
- (void)dragged:(UIPanGestureRecognizer *)p {
    CGPoint loc = [p locationInView:self.superview];
    self.center = loc;
}
@end

// ボタンを表示する関数
void setupMenu() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
                if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                    window = windowScene.windows.firstObject;
                    break;
                }
            }
        } else {
            window = [UIApplication sharedApplication].keyWindow;
        }

        if (window) {
            DraggableButton *menuButton = [DraggableButton buttonWithType:UIButtonTypeCustom];
            menuButton.frame = CGRectMake(100, 100, 60, 60);
            menuButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
            menuButton.layer.cornerRadius = 30;
            [menuButton setTitle:@"MOD" forState:UIControlStateNormal];
            
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:menuButton action:@selector(dragged:)];
            [menuButton addGestureRecognizer:pan];
            
            [window addSubview:menuButton];
        }
    });
}

%ctor {
    setupMenu();
}
