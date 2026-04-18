#import <UIKit/UIKit.h>

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 画面を取得
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (!window && @available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject;
                    break;
                }
            }
        }

        // ボタンを作成（左上に固定）
        if (window) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(50, 50, 80, 40);
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:@"MOD MENU" forState:UIControlStateNormal];
            btn.layer.cornerRadius = 10;
            btn.clipsToBounds = YES;
            
            // 最前面に表示
            btn.window.windowLevel = UIWindowLevelAlert + 1;
            [window addSubview:btn];
        }
    });
}
