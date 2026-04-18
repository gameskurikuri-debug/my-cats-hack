#import <UIKit/UIKit.h>

@interface DragButton : UIButton
@end
@implementation DragButton
- (void)dragged:(UIPanGestureRecognizer *)p {
    CGPoint loc = [p locationInView:self.superview];
    self.center = loc;
}
@end

static DragButton *btn;

// ボタンを表示するまで何度も繰り返す関数
void tryAddButton() {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                window = scene.windows.firstObject; break;
            }
        }
    }
    if (!window) window = [UIApplication sharedApplication].keyWindow;

    if (window && !btn) {
        btn = [DragButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(80, 80, 60, 60);
        btn.backgroundColor = [UIColor blueColor]; // 確実に見えるように「青」
        btn.layer.cornerRadius = 30;
        [btn setTitle:@"MENU" forState:UIControlStateNormal];
        btn.layer.zPosition = 10000;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:btn action:@selector(dragged:)];
        [btn addGestureRecognizer:pan];
        
        [window addSubview:btn];
        NSLog(@"--- MOD: Success Added! ---");
    } else if (!btn) {
        // まだ画面の準備ができていなければ、1秒後に再試行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            tryAddButton();
        });
    }
}

%ctor {
    tryAddButton();
}
