#import <UIKit/UIKit.h>

// ドラッグ移動用のクラス
@interface DraggableButton : UIButton
@end

@implementation DraggableButton
- (void)dragged:(UIPanGestureRecognizer *)p {
    if (p.state == UIGestureRecognizerStateChanged) {
        CGPoint loc = [p locationInView:self.superview];
        self.center = loc;
    }
}
@end

static DraggableButton *menuButton;

%ctor {
    // ゲーム起動から7秒後に実行（読み込み待ち）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject;
                    break;
                }
            }
        }
        if (!window) window = [UIApplication sharedApplication].keyWindow;

        if (window) {
            // ボタンの作成
            menuButton = [DraggableButton buttonWithType:UIButtonTypeCustom];
            // 画面の真ん中あたり(x:100, y:200)に配置
            menuButton.frame = CGRectMake(100, 200, 60, 60);
            menuButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.8]; // 目立つ赤
            menuButton.layer.cornerRadius = 30;
            [menuButton setTitle:@"MOD" forState:UIControlStateNormal];
            menuButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            
            // ドラッグ機能を追加
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:menuButton action:@selector(dragged:)];
            [menuButton addGestureRecognizer:pan];
            
            // 常に最前面に表示する設定
            menuButton.layer.zPosition = 9999;
            [window addSubview:menuButton];
            [window bringSubviewToFront:menuButton];
            
            NSLog(@"--- Battle Cats Mod: Button Force Added! ---");
        }
    });
}
