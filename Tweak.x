#import <UIKit/UIKit.h>

// ドラッグ可能なボタンの定義
@interface DraggableButton : UIButton
@end
@implementation DraggableButton
- (void)dragged:(UIPanGestureRecognizer *)p {
    CGPoint loc = [p locationInView:self.superview];
    self.center = loc;
}
@end

// --- 改造の「住所」設定 ---
// ここに Il2CppDumper などで調べたオフセットを入れます
uintptr_t catFoodOffset = 0x1234567; // 猫缶の住所（例）
uintptr_t xpOffset = 0x7654321;      // XPの住所（例）

// --- 書き換え処理 ---
void hackGame() {
    // 猫缶を 999,999 に固定する（例）
    // *(int*)(baseAddr + catFoodOffset) = 999999;
    NSLog(@"--- Mod: Cat Food & XP Hacked! ---");
}

void setupMenu() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject; break;
                }
            }
        } else {
            window = [UIApplication sharedApplication].keyWindow;
        }

        if (window) {
            // ドラッグできるボタンを作成
            DraggableButton *btn = [DraggableButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100, 100, 60, 60);
            btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            btn.layer.cornerRadius = 30;
            [btn setTitle:@"MENU" forState:UIControlStateNormal];
            
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:btn action:@selector(dragged:)];
            [btn addGestureRecognizer:pan];
            
            // ボタンを押した時の動作（改造実行）
            [btn addTarget:nil action:@selector(showPopup) forControlEvents:UIControlEventTouchUpInside];
            
            [window addSubview:btn];
        }
    });
}

// ボタンを押した時に出るメッセージ（動作確認用）
@implementation UIViewController (ModPopup)
- (void)showPopup {
    hackGame();
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"MOD Menu" message:@"Cat Food & XP Hacked!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end

%ctor {
    setupMenu();
}
