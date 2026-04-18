#import <UIKit/UIKit.h>

@interface MinecraftMenu : UIView
@property (nonatomic, strong) UIButton *menuButton;
@end

@implementation MinecraftMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.menuButton.frame = CGRectMake(0, 0, 60, 60);
        self.menuButton.backgroundColor = [UIColor greenColor]; // マイクラっぽく「緑」
        self.menuButton.layer.cornerRadius = 30;
        [self.menuButton setTitle:@"MC" forState:UIControlStateNormal];
        
        // ドラッグ移動の設定
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.menuButton addGestureRecognizer:pan];
        
        // タップした時の動作（ここに機能を追加していく）
        [self.menuButton addTarget:self action:@selector(menuTapped) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.menuButton];
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)p {
    CGPoint loc = [p locationInView:self.superview];
    self.center = loc;
}

- (void)menuTapped {
    // 動作確認用のポップアップ
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"MC Client" message:@"機能を選択してください" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"閉じる" style:UIAlertActionStyleCancel handler:nil]];
    
    // 最前面のViewControllerを取得して表示
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (root.presentedViewController) root = root.presentedViewController;
    [root presentViewController:alert animated:YES completion:nil];
}

@end

%ctor {
    // マイクラは起動が重いので、15秒待ってからボタンを出す
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject; break;
                }
            }
        }
        if (!window) window = [UIApplication sharedApplication].keyWindow;

        if (window) {
            MinecraftMenu *menu = [[MinecraftMenu alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
            menu.layer.zPosition = 99999; // 圧倒的最前面
            [window addSubview:menu];
            NSLog(@"--- Minecraft Menu Loaded! ---");
        }
    });
}
