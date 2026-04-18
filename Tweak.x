#import <UIKit/UIKit.h>

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *window = nil;
        
        // iOS 13以降の正しいウィンドウ取得方法
        if (@available(iOS 13.0, *)) {
            NSSet *scenes = [[UIApplication sharedApplication] connectedScenes];
            for (UIScene *scene in scenes) {
                if ([scene isKindOfClass:[UIWindowScene class]] && scene.activationState == UISceneActivationStateForegroundActive) {
                    window = ((UIWindowScene *)scene).windows.firstObject;
                    break;
                }
            }
        }
        
        // iOS 13未満、または上記で見つからなかった場合
        if (!window) {
            window = [[UIApplication sharedApplication] keyWindow];
        }

        if (window) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(50, 100, 100, 50);
            btn.backgroundColor = [UIColor blueColor];
            [btn setTitle:@"MENU" forState:UIControlStateNormal];
            btn.layer.cornerRadius = 25;
            btn.clipsToBounds = YES;
            
            // タップした時の動作を追加（とりあえず今は何もしない）
            [window addSubview:btn];
            
            NSLog(@"--- Battle Cats Mod: Button Added! ---");
        }
    });
}
