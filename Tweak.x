#import <UIKit/UIKit.h>

// メニューのボタンを作る関数
void setupMenu() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // 丸いボタンを作成
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake(100, 100, 60, 60);
        menuButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        menuButton.layer.cornerRadius = 30;
        [menuButton setTitle:@"MOD" forState:UIControlStateNormal];
        
        // ボタンをドラッグ移動できるようにする
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:menuButton action:@selector(dragged:)];
        [menuButton addGestureRecognizer:pan];
        
        [window addSubview:menuButton];
    });
}

// ボタンを動かすための設定（簡易版）
@implementation UIButton (Draggable)
- (void)dragged:(UIPanGestureRecognizer *)p {
    CGPoint loc = [p locationInView:self.superview];
    self.center = loc;
}
@end

%ctor {
    setupMenu();
}
